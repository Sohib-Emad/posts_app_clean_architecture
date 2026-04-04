import 'package:clean_architecture_posts_app/core/network/network_checker.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasource/local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasource/remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/repo/posts_repo_impl.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repo/base_repo_posts.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecase/add_post_usecase.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecase/delete_posts_usecase.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecase/getall_posts_usecase.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecase/update_post_usecase.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/get_all_posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Posts

  // Bloc
  sl.registerFactory(() => PostsBloc(getallPostsUsecase: sl()));
  sl.registerFactory(
    () => AddDeleteUpdatePostsBloc(
      addPostUsecase: sl(),
      updatePostUsecase: sl(),
      deletePostUsecase: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetallPostsUsecase(baseRepoPosts: sl()));
  sl.registerLazySingleton(() => AddPostUsecase(baseRepoPosts: sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(baseRepoPosts: sl()));
  sl.registerLazySingleton(() => DeletePostsUsecase(baseRepoPosts: sl()));

  // Repo
  sl.registerLazySingleton<BaseRepoPosts>(
    () => PostsRepoImpl(
      remoteDataSourcePosts: sl(),
      localDataSourcePosts: sl(),
      networkChecker: sl(),
    ),
  );

  // Datasource
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(httpClient: sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkChecker>(
    () => NetworkCheckerImpl(connectionChecker: sl()),
  );

  //! External
  final sharedPrefs = await SharedPreferences.getInstance(); // ✅ await
  sl.registerLazySingleton(() => sharedPrefs);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
