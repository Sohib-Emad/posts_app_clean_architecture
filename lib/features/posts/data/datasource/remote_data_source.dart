import 'dart:convert';

import 'package:clean_architecture_posts_app/core/error/exception.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/posts_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<PostsModel>> getAllPosts();
  Future<Unit> addPost(PostsModel post);
  Future<Unit> updatePost(PostsModel post);
  Future<Unit> deletePost(int id);
}

const String baseUrl = 'your-base-Url';

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client httpClient;
  RemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<PostsModel>> getAllPosts() async {
    final response = await httpClient.get(
      Uri.parse(baseUrl + '/posts/'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List decodeJsonData = json.decode(response.body);
      List<PostsModel> postsModels = decodeJsonData
          .map<PostsModel>((e) => PostsModel.fromJson(e))
          .toList();
      return postsModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostsModel post) async {
    final body = {"title": post.title, "body": post.body};
    final response = await httpClient.post(
      Uri.parse(baseUrl + '/posts/'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await httpClient.delete(
      Uri.parse(baseUrl + '/posts/${id.toString()}'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostsModel post) async {
    final postid = post.id.toString();
    final body = {"title": post.title, "body": post.body};
    final responsr = await httpClient.patch(
      Uri.parse(baseUrl + '/posts/${postid.toString()}'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (responsr.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
