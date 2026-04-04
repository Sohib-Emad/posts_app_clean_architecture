// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:clean_architecture_posts_app/core/routes/app_routes.dart';
import 'package:clean_architecture_posts_app/core/routes/routes.dart';

class PostsApp extends StatelessWidget {
  final AppRoutes appRoutes;
  const PostsApp({super.key, required this.appRoutes});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Posts App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          initialRoute: Routes.home,
          onGenerateRoute: appRoutes.onGenerateRoute,
        );
      },
    );
  }
}
