import 'package:mobx/mobx.dart';
import 'package:flutter_home_work11/data/models/post.dart';
import 'package:flutter_home_work11/data/models/comment.dart';
import 'package:flutter_home_work11/data/services/post_service.dart';

part 'post_store.g.dart';

class PostStore = PostStoreBase with _$PostStore;

abstract class PostStoreBase with Store {
  final PostService postService = PostService();

  @observable
  ObservableList<Post> posts = ObservableList<Post>();

  @observable
  ObservableList<Comment> comments = ObservableList<Comment>();

  @observable
  String? errorMessage;

  @observable
  bool isLoading = false;

  PostStoreBase() {
    init();
  }

  @action
  Future<void> init() async {
    await loadPosts();
  }

  @action
  Future<void> loadPosts() async {
    isLoading = true;
    errorMessage = null;
    try {
      final data = await postService.fetchPosts();
      posts = ObservableList.of(data);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadComments(int postId) async {
    isLoading = true;
    errorMessage = null;
    try {
      final data = await postService.fetchComments(postId);
      comments = ObservableList.of(data);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deletePost(int postId) async {
    isLoading = true;
    errorMessage = null;
    try {
      final success = await postService.deletePost(postId);
      if (success) {
        posts.removeWhere((post) => post.id == postId);
      } else {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
