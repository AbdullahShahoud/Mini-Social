import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/routing/router.dart';
import 'package:social_app/features/posts/presentation/cubit/cubit/posts_cubit_cubit.dart';

import '../../../../core/services/injection.dart';
import '../../../auth/presentation/widget/button.dart';
import '../widget/post_item_edite.dart';

class PostsMe extends StatelessWidget {
  const PostsMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routers.createPosts);
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) =>
            PostsCubitCubit(getIt(), getIt(), getIt(), getIt()),
        child: SafeArea(
          child: BlocBuilder<PostsCubitCubit, PostsCubitState>(
            builder: (context, state) {
              if (state is GetPostsCubitLoding) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetPostsCubitEroor) {
                return Center(child: Text('خطأ: ${state.massege}'));
              } else if (state is GetPostsCubitSuccess) {
                final posts = state.postsResponseModel.data.posts;

                if (posts.isEmpty) {
                  return Center(child: Text('لا توجد منشورات'));
                }
                var cubit = PostsCubitCubit.get(context);
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5.0,
                          margin: EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Image(
                                image: NetworkImage(
                                  'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                                ),
                                fit: BoxFit.cover,
                                height: 200.0,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'communicate with friends',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Container(
                          height: 500,
                          child: ListView.builder(
                            itemCount: cubit.posts!.data.posts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: buildPostItemEdite(
                                  cubit.posts!.data.posts[index],
                                  context,
                                  () {
                                    cubit.selectEdit =
                                        cubit.posts!.data.posts[index].id;
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Container(
                                          height: 60,
                                          child: Center(
                                            child: Text('هل تريد حذف البوست'),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        actions: [
                                          ButtonAuth(
                                            text: 'حسنا',
                                            function: () {
                                              PostsCubitCubit.get(
                                                context,
                                              ).deletePost();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  () {
                                    cubit.selectEdit =
                                        cubit.posts!.data.posts[index].id;
                                    Navigator.of(
                                      context,
                                    ).pushNamed(Routers.editePosts);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
