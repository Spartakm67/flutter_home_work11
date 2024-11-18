// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostStore on PostStoreBase, Store {
  late final _$postsAtom = Atom(name: 'PostStoreBase.posts', context: context);

  @override
  ObservableList<Post> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<Post> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$commentsAtom =
      Atom(name: 'PostStoreBase.comments', context: context);

  @override
  ObservableList<Comment> get comments {
    _$commentsAtom.reportRead();
    return super.comments;
  }

  @override
  set comments(ObservableList<Comment> value) {
    _$commentsAtom.reportWrite(value, super.comments, () {
      super.comments = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'PostStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'PostStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadPostsAsyncAction =
      AsyncAction('PostStoreBase.loadPosts', context: context);

  @override
  Future<void> loadPosts() {
    return _$loadPostsAsyncAction.run(() => super.loadPosts());
  }

  late final _$loadCommentsAsyncAction =
      AsyncAction('PostStoreBase.loadComments', context: context);

  @override
  Future<void> loadComments(int postId) {
    return _$loadCommentsAsyncAction.run(() => super.loadComments(postId));
  }

  late final _$deletePostAsyncAction =
      AsyncAction('PostStoreBase.deletePost', context: context);

  @override
  Future<void> deletePost(int postId) {
    return _$deletePostAsyncAction.run(() => super.deletePost(postId));
  }

  @override
  String toString() {
    return '''
posts: ${posts},
comments: ${comments},
errorMessage: ${errorMessage},
isLoading: ${isLoading}
    ''';
  }
}
