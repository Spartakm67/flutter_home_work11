import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_home_work11/domain/store/post_store.dart';
import 'package:flutter_home_work11/presentation/screens/comments_screen.dart';

class PostListScreen extends StatelessWidget {
  final PostStore postStore = PostStore();

  PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: Observer(
        builder: (_) {
          if (postStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (postStore.errorMessage != null) {
            return Center(child: Text("Error: ${postStore.errorMessage}"));
          }

          return ListView.builder(
            itemCount: postStore.posts.length,
            itemBuilder: (context, index) {
              final post = postStore.posts[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      await postStore.deletePost(post.id);
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            postStore.errorMessage != null
                                ? "Failed to delete post"
                                : "Post deleted successfully!",
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/comments', arguments: {'postId': post.id},);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => CommentsScreen(postId: post.id),
                    //   ),
                    // );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
