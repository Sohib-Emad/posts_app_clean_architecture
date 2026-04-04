import 'package:clean_architecture_posts_app/core/error/exception.dart';
import 'package:clean_architecture_posts_app/core/error/failure.dart';
import 'package:clean_architecture_posts_app/core/network/network_checker.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasource/local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasource/remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/posts_model.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entity/posts_entity.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repo/base_repo_posts.dart';
import 'package:dartz/dartz.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepoImpl implements BaseRepoPosts {
  final RemoteDataSource remoteDataSourcePosts;
  final LocalDataSource localDataSourcePosts;
  final NetworkChecker networkChecker;
  PostsRepoImpl({
    required this.remoteDataSourcePosts,
    required this.localDataSourcePosts,
    required this.networkChecker,
  });
  @override
  Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
    if (await networkChecker.isConnected) {
      try {
        final response = await remoteDataSourcePosts.getAllPosts();
        await localDataSourcePosts.cachePosts(response);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<PostsEntity> localPosts = await localDataSourcePosts
            .getCachedPosts(); // ✅ explicit type
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostsEntity post) async {
    final PostsModel postsModel = PostsModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return _getMessage(() {
      return remoteDataSourcePosts.addPost(postsModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostsEntity post) async {
    final PostsModel postsModel = PostsModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return _getMessage(() {
      return remoteDataSourcePosts.updatePost(postsModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return _getMessage(() {
      return remoteDataSourcePosts.deletePost(id);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
    // ✅ camelCase
    DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost,
  ) async {
    if (await networkChecker.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
