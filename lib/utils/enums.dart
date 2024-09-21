/// Enum representing the different states of the post-fetching process
enum PostStatus {
  /// Indicates that posts are currently being loaded from the API
  loading,

  /// Indicates that posts have been successfully fetched from the API
  success,

  /// Indicates that there was an error while fetching posts
  failure
}
