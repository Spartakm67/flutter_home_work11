import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_home_work11/domain/store/post_store.dart';
import 'package:flutter_home_work11/domain/store/scroll_store.dart';
import 'package:flutter_home_work11/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_home_work11/presentation/styles/text_styles.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final PostStore postStore = PostStore();
  final ScrollStore scrollStore = ScrollStore();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      scrollStore.updateScrollPosition(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            controller: _scrollController,
            itemCount: postStore.posts.length,
            itemBuilder: (context, index) {
              final post = postStore.posts[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Name: ',
                          style: TextStyles.spanKeyText,
                        ),
                        TextSpan(
                          text: post.title,
                          style: TextStyles.spanTitleText,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Post: ',
                              style: TextStyles.spanPostText,
                            ),
                            TextSpan(
                              text: post.body,
                              style: TextStyles.spanBodyText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
      floatingActionButton: Observer(
        builder: (_) => scrollStore.showScrollToTopButton
            ? FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Colors.blue,
                onPressed: _scrollToTop,
                child: const Icon(Icons.arrow_upward, color: Colors.white,),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
