import 'package:clean_architecture_posts_app/features/posts/domain/entity/posts_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostListWidget extends StatelessWidget {
  final List<PostsEntity> posts;
  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,

      itemBuilder: (BuildContext context, int index) {
       return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(posts[index].body, style: TextStyle(fontSize: 16.sp)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.h),
          onTap: () {},
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(thickness: 1.w),
    );
  }
}
