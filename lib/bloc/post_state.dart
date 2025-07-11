import 'package:equatable/equatable.dart';
import 'package:post/model/post_model.dart';
import 'package:post/utils/enums.dart';

class PostStates extends Equatable {
  final List<PostModel> postList;
  final List<PostModel> tempPostList;
  final PostStatus postStatus;
  final String message;
  final String searchMessage;

  const PostStates(
      {this.postList = const <PostModel>[],
      this.tempPostList = const <PostModel>[],
      this.postStatus = PostStatus.loading,
      this.searchMessage = '',
      this.message = ''});

  PostStates copyWith(
      {List<PostModel>? postList,
      PostStatus? postStatus,
      String? message,
      String? searchMessage,
      List<PostModel>? tempPostList}) {
    return PostStates(
        message: message ?? '',
        searchMessage: searchMessage ?? '',
        postList: postList ?? this.postList,
        tempPostList: tempPostList ?? this.tempPostList,
        postStatus: postStatus ?? this.postStatus);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [postList, postStatus, message, tempPostList, searchMessage];
}
