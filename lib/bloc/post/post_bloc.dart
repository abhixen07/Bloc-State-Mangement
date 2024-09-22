import 'package:bloc/bloc.dart';
import 'package:bloc_state/bloc/post/post_event.dart';
import 'package:bloc_state/bloc/post/post_state.dart';
import 'package:bloc_state/model/posts_model.dart';
import 'package:bloc_state/repository/post_repository.dart';
import 'package:bloc_state/utils/enums.dart';

/// Bloc responsible for managing post-related events and states
class PostBloc extends Bloc<PostEvent, PostState> {
  List<PostModel> tempPostList = [];

  /// Repository that handles API calls for fetching posts
  PostRepository postRepository = PostRepository();

  /// Initializing the Bloc with an initial state and setting up event handling
  PostBloc() : super(const PostState()) {
    // Listening for the PostFetched event and triggering the fetchPostApi function
    on<PostFetched>(fetchPostApi);
    on<SearchItem>(filterList);
  }

  /// Method to fetch posts from the API and update the state based on the response
  Future<void> fetchPostApi(PostFetched event, Emitter<PostState> emit) async {
    // Fetch posts from the repository
    await postRepository.fetchPost().then((value) {
      // On success, emit a new state with the list of posts and a success status
      emit(state.copyWith(
          postStatus: PostStatus.success,
          postsList: value,
          message: 'success'));
    }).onError((error, stackTrace) {
      // On error, log the error and emit a failure state with the error message
      print(error);
      print(stackTrace);
      emit(state.copyWith(
          postStatus: PostStatus.failure, message: error.toString()));
    });
  }

  void filterList(SearchItem event, Emitter<PostState> emit) {
    // Check if the search string is empty
    if (event.stSearch.isEmpty) {
      // If search is empty, clear the temporary post list and remove any search message
      emit(state.copyWith(tempPostList: [], searchMessage: ''));
    } else {
      // Filter the post list based on whether the email contains the search string (case insensitive)
      tempPostList = state.postList
          .where((element) => element.email
              .toString()
              .toLowerCase()
              .contains(event.stSearch.toString().toLowerCase()))
          .toList();

      // If the filtered list is empty, display a 'No data found' message
      if (tempPostList.isEmpty) {
        emit(state.copyWith(
            tempPostList: tempPostList, searchMessage: 'No data found'));
      } else {
        // If the filtered list contains items, clear the search message
        emit(state.copyWith(tempPostList: tempPostList, searchMessage: ''));
      }
    }
  }
}
