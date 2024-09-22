import 'package:bloc_state/bloc/post/post_bloc.dart';
import 'package:bloc_state/bloc/post/post_event.dart';
import 'package:bloc_state/bloc/post/post_state.dart';
import 'package:bloc_state/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A StatefulWidget that displays a list of posts fetched using BLoC
class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the PostFetched event to load posts when the screen initializes
    context.read<PostBloc>().add(PostFetched());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List using BLoC'),
      ),
      // Using BlocBuilder to rebuild the UI based on the current PostState
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              // Show a loading indicator while posts are being fetched
              return const Center(child: CircularProgressIndicator());

            case PostStatus.failure:
              // Display the error message if fetching posts failed
              return Center(child: Text(state.message.toString()));

            case PostStatus.success:
              // If the list of posts is empty, show a 'no posts' message
              if (state.postList.isEmpty) {
                return const Center(child: Text('No posts'));
              }
              // Otherwise, display the list of posts in a ListView
              return Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search with Email',
                      border: OutlineInputBorder(),
                    ),
                    // On search, the SearchItem event is triggered
                    onChanged: (filterKey){
                      context.read<PostBloc>().add(SearchItem(filterKey));
                    },
                  ),
                  Expanded(
                    // Shows search message if no results are found
                  child: state.searchMessage.isNotEmpty ?
                    Center(child: Text(state.searchMessage.toString())) :
                    // Displays the filtered or full post list
                    ListView.builder(
                      itemCount: state.tempPostList.isEmpty ? state.postList.length : state.tempPostList.length,
                      itemBuilder: (context, index) {
                        // Checks if the filtered list is being used or not
                        if(state.tempPostList.isNotEmpty){
                          final item = state.tempPostList[index];
                          // Displays each post in a card with email and body
                          return Card(
                            child: ListTile(
                              // Display each post's email as the title and the body as the subtitle
                              title: Text(item.email.toString()),
                              subtitle: Text(item.body.toString()),
                            ),
                          );
                        }else{
                          final item = state.postList[index];
                          return Card(
                            child: ListTile(
                              // Display each post's email as the title and the body as the subtitle
                              title: Text(item.email.toString()),
                              subtitle: Text(item.body.toString()),
                            ),
                          );

                        }



                      },
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
