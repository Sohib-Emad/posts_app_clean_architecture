import 'package:clean_architecture_posts_app/core/error/failure.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecase/getall_posts_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entity/posts_entity.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetallPostsUsecase getallPostsUsecase;

  PostsBloc({required this.getallPostsUsecase}) : super(PostsInitial()) {
    on<GetAllPostsEvent>(_onGetAllPosts);
    on<RefreshPostsEvent>(_onRefreshPosts);
  }

  Future<void> _fetchPosts(Emitter<PostsState> emit) async {
    emit(PostsLoading());
    final result = await getallPostsUsecase();
    emit(_mapEitherToState(result));
  }

  Future<void> _onGetAllPosts(
    GetAllPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    await _fetchPosts(emit);
  }

  Future<void> _onRefreshPosts(
    RefreshPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    await _fetchPosts(emit);
  }

  PostsState _mapEitherToState(Either<Failure, List<PostsEntity>> either) {
    return either.fold(
      (failure) => PostsError(message: _mapFailureToMessage(failure)),
      (posts) => PostsLoaded(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return switch (failure) {
      ServerFailure() => 'Server error occurred',
      EmptyCacheFailure() => 'Cache error occurred',
      OfflineFailure() => 'No internet connection',
      _ => 'Unexpected error',
    };
  }
}
