import 'package:clean_architecture_posts_app/core/error/failure.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repo/base_repo_posts.dart';
import 'package:dartz/dartz.dart';

class DeletePostsUsecase {
  final BaseRepoPosts baseRepoPosts;

  DeletePostsUsecase({required this.baseRepoPosts});

  Future<Either<Failure, Unit>> call(int id) async {
    return await baseRepoPosts.deletePost(id);
  }
}
