import 'package:clean_architecture_posts_app/core/di/di.dart';
import 'package:clean_architecture_posts_app/core/routes/routes.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/get_all_posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<PostsBloc>()),
              BlocProvider(create: (_) => sl<AddDeleteUpdatePostsBloc>()),
            ],
            child: const HomePage(),
          ),
        );

      default:
        return null;
    }
  }
}