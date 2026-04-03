import 'package:clean_architecture_posts_app/core/const/message.dart';
import 'package:clean_architecture_posts_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entity/posts_entity.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecase/add_post_usecase.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecase/delete_posts_usecase.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecase/update_post_usecase.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_posts_event.dart';
part 'add_delete_update_posts_state.dart';
class AddDeleteUpdatePostsBloc
    extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostsState> {
  final AddPostUsecase addPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostsUsecase deletePostUsecase;

  AddDeleteUpdatePostsBloc({
    required this.addPostUsecase,
    required this.updatePostUsecase,
    required this.deletePostUsecase,
  }) : super(AddDeleteUpdatePostsInitial()) {
    on<AddPostEvent>(_onAddPost);
    on<UpdatePostEvent>(_onUpdatePost);
    on<DeletePostEvent>(_onDeletePost);
  }

  Future<void> _onAddPost(
    AddPostEvent event,
    Emitter<AddDeleteUpdatePostsState> emit,
  ) async {
    emit(AddDeleteUpdatePostsLoading());
    final result = await addPostUsecase(event.postsEntity);
    emit(_eitherDoneMessageOrErrorState(result, addSuccessMessage));
  }

  Future<void> _onUpdatePost(
    UpdatePostEvent event,
    Emitter<AddDeleteUpdatePostsState> emit,
  ) async {
    emit(AddDeleteUpdatePostsLoading());
    final result = await updatePostUsecase(event.postsEntity);
    emit(_eitherDoneMessageOrErrorState(result, updateSuccessMessage));
  }

  Future<void> _onDeletePost(
    DeletePostEvent event,
    Emitter<AddDeleteUpdatePostsState> emit,
  ) async {
    emit(AddDeleteUpdatePostsLoading());
    final result = await deletePostUsecase(event.id);
    emit(_eitherDoneMessageOrErrorState(result, deleteSuccessMessage));
  }

  AddDeleteUpdatePostsState _eitherDoneMessageOrErrorState(
    Either<Failure, Unit> either,
    String message,
  ) {
    return either.fold(
      (failure) => AddDeleteUpdatePostsFailure(
        errorMessage: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdatePostsState(message: message),
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
