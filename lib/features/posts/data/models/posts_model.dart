import 'package:clean_architecture_posts_app/features/posts/domain/entity/posts_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'posts_model.g.dart';

@JsonSerializable()
class PostsModel extends PostsEntity {
  const PostsModel({
    required super.id,
    required super.title,
    required super.body,
  });
  factory PostsModel.fromJson(Map<String, dynamic> json) =>
      _$PostsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostsModelToJson(this);
}
