import 'package:bloc/bloc.dart';
import 'package:bloc_state/bloc/post/post_event.dart';
import 'package:bloc_state/bloc/post/post_state.dart';
import 'package:bloc_state/repository/post_repository.dart';
import 'package:bloc_state/utils/enums.dart';

/// Bloc responsible for managing post-related events and states
class PostBloc extends Bloc<PostEvent, PostState> {
  /// Repository that handles API calls for fetching posts
  PostRepository postRepository = PostRepository();

  /// Initializing the Bloc with an initial state and setting up event handling
  PostBloc() : super(const PostState()) {
    // Listening for the PostFetched event and triggering the fetchPostApi function
    on<PostFetched>(fetchPostApi);
  }

  /// Method to fetch posts from the API and update the state based on the response
  Future<void> fetchPostApi(PostFetched event, Emitter<PostState> emit) async {
    // Fetch posts from the repository
    await postRepository.fetchPost().then((value) {
      // On success, emit a new state with the list of posts and a success status
      emit(state.copyWith(postStatus: PostStatus.success, postsList: value, message: 'success'));
    }).onError((error, stackTrace) {
      // On error, log the error and emit a failure state with the error message
      print(error);
      print(stackTrace);
      emit(state.copyWith(postStatus: PostStatus.failure, message: error.toString()));
    });
  }
}
