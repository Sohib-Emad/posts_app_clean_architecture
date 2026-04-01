import 'dart:convert';
import 'dart:developer';
import 'package:clean_architecture_posts_app/core/error/exception.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/posts_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String cachedPostsKey = 'CACHED_POSTS';

abstract class LocalDataSource {
  Future<List<PostsModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostsModel> postsModel);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;
  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostsModel> postsModels) {
    List<Map<String, dynamic>> postsModelsToJson = postsModels
        .map<Map<String, dynamic>>((e) => e.toJson())
        .toList();
    log(postsModelsToJson.toString());

    // Result:
    // [{"id":1,"title":"Hello","body":"World"}, {"id":2,"title":"Dart","body":"Flutter"}]
    final savetoSharedprefs = sharedPreferences.setString(
      cachedPostsKey,
      json.encode(postsModelsToJson),
    );
    log(savetoSharedprefs.toString());
    // Result:
    // '[{"id":1,"title":"Hello","body":"World"},{"id":2,"title":"Dart","body":"Flutter"}]'

    return Future.value(unit);
  }

  @override
  Future<List<PostsModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(cachedPostsKey);
    // Result:
    // '[{"id":1,"title":"Hello","body":"World"},{"id":2,"title":"Dart","body":"Flutter"}]'

    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      // Result:
      // [{"id":1,"title":"Hello","body":"World"}, {"id":2,"title":"Dart","body":"Flutter"}]

      List<PostsModel> postsModels = decodeJsonData
          .map<PostsModel>((e) => PostsModel.fromJson(e))
          .toList();
      // Result:
      // [PostsModel(id:1, title:"Hello", body:"World"), PostsModel(id:2, ...)]

      return Future.value(postsModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
