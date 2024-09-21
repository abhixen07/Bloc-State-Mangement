import 'package:bloc_state/bloc/post/post_bloc.dart';
import 'package:bloc_state/bloc/post/post_event.dart';
import 'package:bloc_state/bloc/post/post_state.dart';
import 'package:bloc_state/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math show Random;

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
              return ListView.builder(
                itemCount: state.postList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      // Display each post's email as the title and the body as the subtitle
                      title: Text(state.postList[index].email.toString()),
                      subtitle: Text(state.postList[index].body.toString()),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
