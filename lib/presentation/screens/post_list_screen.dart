import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_home_work11/domain/store/post_store.dart';
import 'package:flutter_home_work11/presentation/widgets/custom_app_bar.dart';

class PostListScreen extends StatelessWidget {
  final PostStore postStore = PostStore();

  PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Posts'),
      body: Observer(
        builder: (_) {
          if (postStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (postStore.errorMessage != null) {
            return Center(child: Text('Error: ${postStore.errorMessage}'));
          }
          return ListView.builder(
            itemCount: postStore.posts.length,
            itemBuilder: (context, index) {
              final post = postStore.posts[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text('Name: ${post.title}'),
                  subtitle: Text('Post: ${post.body}'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      final shouldDelete = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Deletion'),
                            content: const Text(
                              'Are you sure you want to delete this post?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                      if (shouldDelete == true) {
                        await postStore.deletePost(post.id);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text(
                              postStore.errorMessage != null
                                  ? 'Failed to delete post'
                                  : 'Post deleted successfully!',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/comments',
                      arguments: {'postId': post.id},
                    );
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
