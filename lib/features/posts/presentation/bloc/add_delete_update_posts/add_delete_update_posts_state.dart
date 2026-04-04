part of 'add_delete_update_posts_bloc.dart';

sealed class AddDeleteUpdatePostsState extends Equatable {
  const AddDeleteUpdatePostsState();

  @override
  List<Object> get props => [];
}

final class AddDeleteUpdatePostsInitial extends AddDeleteUpdatePostsState {}

final class AddDeleteUpdatePostsLoading extends AddDeleteUpdatePostsState {}

final class AddDeleteUpdatePostsFailure extends AddDeleteUpdatePostsState {
  final String errorMessage;

  const AddDeleteUpdatePostsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class MessageAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState {
  final String message;

  const MessageAddDeleteUpdatePostsState({required this.message});

  @override
  List<Object> get props => [message];
}
