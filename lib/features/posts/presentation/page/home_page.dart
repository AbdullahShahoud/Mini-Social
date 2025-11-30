import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/services/injection.dart';
import 'package:social_app/features/posts/presentation/page/search_posts.dart';
import '../cubit/cubit/posts_cubit_cubit.dart';
import '../widget/post_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            PostsCubitCubit(getIt(), getIt(), getIt(), getIt())..getPosts(),
        child: SafeArea(
          child: BlocBuilder<PostsCubitCubit, PostsCubitState>(
            builder: (context, state) {
              // final cubit = context.read<PostsCubitCubit>();
              if (state is GetPostsCubitLoding) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetPostsCubitEroor) {
                return Center(child: Text('خطأ: ${state.massege}'));
              } else if (state is GetPostsCubitSuccess) {
                final posts = state.postsResponseModel.data.posts;

                if (posts.isEmpty) {
                  return Center(child: Text('لا توجد منشورات'));
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: SearchPosts(
                              postModel: posts,
                              history: ['mm', 'tt', 'yy'],
                            ),
                          );
                        },
                        child: Container(
                          width: 300,
                          height: 35,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 201, 199, 199),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              Spacer(),
                              Text('البحث'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 700,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: buildPostItem(posts[index], context),
                          ),
                          itemCount: posts.length,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              } else {
                // الحالة الابتدائية
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
