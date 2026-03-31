
import 'package:clean_architecture_posts_app/features/posts/data/models/posts_model.dart';
import 'package:dartz/dartz.dart';

abstract class LocalDataSource {
  Future<List<PostsModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostsModel> postsModel);
}


class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<Unit> cachePosts(List<PostsModel> postsModel) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostsModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}