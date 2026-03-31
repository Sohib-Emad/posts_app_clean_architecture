import 'package:clean_architecture_posts_app/features/posts/data/models/posts_model.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDataSource {
  Future<List<PostsModel>> getAllPosts();
  Future<Unit> addPost(PostsModel post);
  Future<Unit> updatePost(PostsModel post);
  Future<Unit> deletePost(int id);
}


class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<Unit> addPost(PostsModel post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostsModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostsModel post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}