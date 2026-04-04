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

const String baseUrl = 'https://dummyjson.com';

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client httpClient;
  RemoteDataSourceImpl({required this.httpClient});

 @override
Future<List<PostsModel>> getAllPosts() async {
  final response = await httpClient.get(
    Uri.parse('$baseUrl/posts'),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> decoded = json.decode(response.body); 
    final List data = decoded['posts'];                               
    return data.map<PostsModel>((e) => PostsModel.fromJson(e)).toList();
  } else {
    throw ServerException();
  }
}


@override
Future<Unit> addPost(PostsModel post) async {
  final response = await httpClient.post(
    Uri.parse('$baseUrl/posts/add'),                                  
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'title': post.title, 'body': post.body}),
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
      Uri.parse('$baseUrl/posts/$id'),
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
    final response = await httpClient.patch(  
      Uri.parse('$baseUrl/posts/${post.id}'),  
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': post.title, 'body': post.body}), 
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}