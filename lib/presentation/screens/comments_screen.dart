import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_home_work11/domain/store/post_store.dart';
import 'package:flutter_home_work11/presentation/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_home_work11/presentation/styles/text_styles.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key, required this.postId});
  final int postId;
  final PostStore postStore = PostStore();

  @override
  Widget build(BuildContext context) {
    postStore.loadComments(postId);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Comments'),
      body: Observer(
        builder: (_) {
          if (postStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (postStore.errorMessage != null) {
            return Center(
              child: Text(
                'Error: ${postStore.errorMessage}',
              ),
            );
          }
          return ListView.builder(
            itemCount: postStore.comments.length,
            itemBuilder: (context, index) {
              final comment = postStore.comments[index];
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
                          text: comment.name,
                          style: TextStyles.spanTitleText,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text(
                            'Email: ',
                            style: TextStyles.spanPostText,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final Uri emailUri = Uri(
                                scheme: 'mailto',
                                path: comment.email,
                                query: 'subject=Hello&body=Your message here',
                              );
                              if (await canLaunchUrl(emailUri)) {
                                await launchUrl(emailUri);
                              } else {
                                throw 'Could not launch $emailUri';
                              }
                            },
                            child: Text(
                              comment.email,
                              style: TextStyles.spanEmailText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Comment: ',
                              style: TextStyles.spanPostText,
                            ),
                            TextSpan(
                              text: comment.body,
                              style: TextStyles.spanBodyText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
