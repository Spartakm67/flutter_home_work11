import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_home_work11/data/models/post.dart';
import 'package:flutter_home_work11/data/models/comment.dart';
import 'package:flutter_home_work11/data/constants/api_constants.dart';

class PostService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<Post>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('$baseUrl${ApiConstants.postsEndpoint}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Comment>> fetchComments(int postId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl${ApiConstants.postsEndpoint}/$postId${ApiConstants.commentsEndpoint}',),);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<bool> deletePost(int postId) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$postId'));

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
