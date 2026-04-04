import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/get_all_posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/message_display_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,

      appBar: _buildAppBar(),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),

      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return LoadingWidget();
          } else if (state is PostsLoaded) {
            return PostListWidget(posts: state.posts);
          } else if (state is PostsError) {
            return MessageDisplayWidget(message: state.message);
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.blueAccent,
      child: const Icon(Icons.add),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Posts',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
    );
  }
}
