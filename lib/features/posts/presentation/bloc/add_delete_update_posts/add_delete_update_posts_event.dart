part of 'add_delete_update_posts_bloc.dart';

sealed class AddDeleteUpdatePostsEvent extends Equatable {
  const AddDeleteUpdatePostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostsEvent {
  final PostsEntity postsEntity;

  const AddPostEvent({required this.postsEntity});

  @override
  List<Object> get props => [postsEntity];
}

class DeletePostEvent extends AddDeleteUpdatePostsEvent {
  final int id;

  const DeletePostEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdatePostEvent extends AddDeleteUpdatePostsEvent {
  final PostsEntity postsEntity;

  const UpdatePostEvent({required this.postsEntity});

  @override
  List<Object> get props => [postsEntity];
}
