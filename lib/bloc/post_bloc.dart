import 'package:bloc/bloc.dart';
import 'package:post/bloc/post_event.dart';
import 'package:post/bloc/post_state.dart';
import 'package:post/model/post_model.dart';
import 'package:post/repository/post_repository.dart';
import 'package:post/utils/enums.dart';

class PostBloc extends Bloc<PostEvent, PostStates> {
  List<PostModel> tempPostList = [];
  PostRepository postRepository = PostRepository();

  PostBloc() : super(const PostStates()) {
    on<FetchPost>(postFetch);
    on<SearchItem>(filterList);
  }

  void filterList(SearchItem event, Emitter<PostStates> emit) {
    if (event.searchString.isEmpty) {
      emit(state.copyWith(tempPostList: [], searchMessage: ''));
    } else {
      tempPostList = state.postList.where((element) => element.email.toString().toLowerCase().contains(event.searchString.toString().toLowerCase()),).toList();
      // tempPostList = state.postList.where((element) => element.email.toString().toLowerCase().toString().contains(event.searchString.toString().toLowerCase())).toList();

      if (tempPostList.isEmpty) {
        emit(state.copyWith(
            tempPostList: tempPostList,
            searchMessage: 'Search Data is not found'));
      } else {
        emit(state.copyWith(tempPostList: tempPostList,searchMessage: ''));
      }
    }
  }

  void postFetch(FetchPost event, Emitter<PostStates> emit) async {
    await postRepository.fetchPost().then(
      (value) {
        emit(state.copyWith(
            postList: value,
            message: 'success',
            postStatus: PostStatus.success));
      },
    ).onError(
      (error, stackTrace) {
        // print(error);
        // print(stackTrace);
        postRepository.fetchPost().then(
          (value) {
            emit(state.copyWith(
              postStatus: PostStatus.failure,
              message: 'Error',
            ));
          },
        );
      },
    );
  }
}
