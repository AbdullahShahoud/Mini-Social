// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/presentation/widget/button.dart';
import 'package:social_app/features/auth/presentation/widget/text_form_field.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/services/posts_image.dart';
import '../cubit/cubit/posts_cubit_cubit.dart';

TextEditingController title = TextEditingController();
TextEditingController content = TextEditingController();
List<String>? photo;
var key = GlobalKey<FormState>();

class CreatePosts extends StatefulWidget {
  CreatePosts({super.key});

  @override
  State<CreatePosts> createState() => _CreatePostsState();
}

class _CreatePostsState extends State<CreatePosts> {
  bool _isLoading = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('اضافة بوست')),
      body: SafeArea(
        child: BlocConsumer<PostsCubitCubit, PostsCubitState>(
          listener: (context, state) {
            if (state is CreatePostsCubitLoding) {
              _isLoading = true;
            }
            if (state is CreatePostsCubitEroor) {
              _isLoading = false;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Container(
                    height: 80,
                    child: Center(child: Text(state.massege)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  actions: [
                    ButtonAuth(
                      text: 'حسنا',
                      function: () {
                        Navigator.pushNamed(context, Routers.home);
                      },
                    ),
                  ],
                ),
              );
            }
            if (state is CreatePostsCubitSuccess) {
              Navigator.of(context).pushNamed(Routers.home);
            }
          },
          builder: (context, state) {
            return Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FromField(
                      controller: title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء ادخال العنوان ";
                        }
                        return null;
                      },
                      icon: Icon(Icons.abc, size: 25, color: Colors.black),
                      text: "العنوان ",
                      color: Color.fromARGB(255, 201, 199, 199),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    FromField(
                      controller: content,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء ادخال المحتوى ";
                        }
                        return null;
                      },
                      icon: Icon(Icons.abc),
                      text: "محتوى المنشور ",
                      color: Color.fromARGB(255, 201, 199, 199),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: IconButton(
                        onPressed: () async {
                          try {
                            final selectedPhoto =
                                await PostService.createPostWithMedia(context);

                            if (selectedPhoto != null &&
                                selectedPhoto.isNotEmpty &&
                                selectedPhoto[0].isNotEmpty &&
                                mounted) {
                              setState(() {
                                photo = selectedPhoto;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('لم يتم اختيار صورة')),
                              );
                            }
                          } catch (e) {}
                        },
                        icon: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 35,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ButtonAuth(
                            text: ' انشاء المنشور',
                            function: () {
                              clickCreate(context);
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void clickCreate(BuildContext context) {
  if (key.currentState!.validate()) {
    context.read<PostsCubitCubit>().createPost(
      title.text,
      content.text,
      photo!,
    );
  }
}
