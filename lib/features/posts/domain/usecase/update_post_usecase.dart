import 'package:clean_architecture_posts_app/core/error/failure.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entity/posts_entity.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repo/base_repo_posts.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUsecase {
  final BaseRepoPosts baseRepoPosts;

  UpdatePostUsecase({required this.baseRepoPosts});

  Future<Either<Failure, Unit>> call(PostsEntity post) async {
    return await baseRepoPosts.updatePost(post);
  } 

}