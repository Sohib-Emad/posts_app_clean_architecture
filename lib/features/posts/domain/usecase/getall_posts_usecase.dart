import 'package:clean_architecture_posts_app/core/error/failure.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entity/posts_entity.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repo/base_repo_posts.dart';
import 'package:dartz/dartz.dart';

class GetallPostsUsecase {
  final BaseRepoPosts baseRepoPosts;

  GetallPostsUsecase({required this.baseRepoPosts});

  Future<Either<Failure, List<PostsEntity>>> call() async {
    return await baseRepoPosts.getAllPosts();
  }
}
