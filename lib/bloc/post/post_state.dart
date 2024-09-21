import 'package:bloc_state/model/posts_model.dart';
import 'package:bloc_state/utils/enums.dart';
import 'package:equatable/equatable.dart';

/// Represents the state of the post fetching process
class PostState extends Equatable {

  // Current status of the post fetching process (loading, success, failure)
  final PostStatus postStatus;

  // List of posts fetched from the API
  final List<PostModel> postList;

  // Message used to show error or success information
  final String message;

  /// Constructor for initializing the PostState with default or provided values
  const PostState({
    this.postStatus = PostStatus.loading,  // Default status is loading
    this.postList = const <PostModel>[],   // Default is an empty list of posts
    this.message = '',                     // Default is an empty message
  });

  /// Method to create a new PostState by copying the current state and
  /// updating specific fields as needed
  PostState copyWith({
    PostStatus? postStatus,
    List<PostModel>? postsList,
    String? message,
  }) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,   // Use provided status or keep current
      postList: postsList ?? this.postList,        // Use provided post list or keep current
      message: message ?? this.message,            // Use provided message or keep current
    );
  }

  @override
  String toString() {
    return '''PostState { status: $postStatus, message: $message, posts: ${postList.length} }''';
  }

  /// Ensures PostState objects can be compared based on their properties
  @override
  List<Object> get props => [postStatus, postList, message];
}
