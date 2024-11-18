import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_home_work11/domain/store/post_store.dart';

class CommentsScreen extends StatelessWidget {
  final int postId;
  final PostStore postStore = PostStore();

  CommentsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    postStore.loadComments(postId);

    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: Observer(
        builder: (_) {
          if (postStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (postStore.errorMessage != null) {
            return Center(child: Text("Error: ${postStore.errorMessage}"));
          }

          return ListView.builder(
            itemCount: postStore.comments.length,
            itemBuilder: (context, index) {
              final comment = postStore.comments[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(comment.name),
                  subtitle: Text(comment.body),
                  trailing: Text(comment.email, style: const TextStyle(fontSize: 12)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
