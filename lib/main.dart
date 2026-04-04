import 'package:clean_architecture_posts_app/core/di/di.dart' as di;
import 'package:clean_architecture_posts_app/posts_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await di.init();
  runApp(PostsApp());
}
