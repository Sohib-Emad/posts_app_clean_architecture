import 'package:clean_architecture_posts_app/core/error/failure.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entity/posts_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BaseRepoPosts {
  Future<Either<Failure, List<PostsEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> addPost(PostsEntity post);
  Future<Either<Failure, Unit>> updatePost(PostsEntity post);
}
