import 'package:equatable/equatable.dart';
import 'package:post/model/post_model.dart';
import 'package:post/utils/enums.dart';

class PostStates extends Equatable {
  final List<PostModel> postList;
  final PostStatus postStatus;
  final String message;

  const PostStates(
      {this.postList = const <PostModel>[],
      this.postStatus = PostStatus.loading,
      this.message = ''});

  PostStates copyWith(
      {List<PostModel>? postList, PostStatus? postStatus, String? message}) {
    return PostStates(
        message: message ?? '',
        postList: postList ?? this.postList,
        postStatus: postStatus ?? this.postStatus);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [postList,postStatus,message];
}
