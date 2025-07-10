import 'package:bloc/bloc.dart';
import 'package:post/bloc/post_event.dart';
import 'package:post/bloc/post_state.dart';
import 'package:post/model/post_model.dart';
import 'package:post/repository/post_repository.dart';
import 'package:post/utils/enums.dart';

class PostBloc extends Bloc<PostEvent, PostStates> {
  PostRepository postRepository = PostRepository();

  PostBloc() : super(const PostStates()) {
    on<FetchPost>(postFetch);
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
        print(error);
        print(stackTrace);
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
// void postFetch(FetchPost event, Emitter<PostStates> emit) {
//   postRepository.fetchPost().then(
//     (value) {
//       emit(state.copyWith(
//           postStatus: PostStatus.success,
//           message: 'Success',
//           postList: value));
//     },
//   ).onError(
//     (error, stackTrace) {
//       emit(state.copyWith(
//           postStatus: PostStatus.failure, message: error.toString()));
//     },
//   );
// }
}
