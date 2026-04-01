// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsModel _$PostsModelFromJson(Map<String, dynamic> json) => PostsModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  body: json['body'] as String,
);

Map<String, dynamic> _$PostsModelToJson(PostsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
