import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/presentation/widget/button.dart';
import 'package:social_app/features/auth/presentation/widget/text_form_field.dart';
import '../../../../core/routing/router.dart';
import '../cubit/cubit/posts_cubit_cubit.dart';

bool _isLoading = false;

class EditePost extends StatelessWidget {
  EditePost({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('تعديل بوست')),
      body: SafeArea(
        child: BlocConsumer<PostsCubitCubit, PostsCubitState>(
          listener: (context, state) {
            if (state is EditePostsCubitLoding) {
              _isLoading = true;
            }
            if (state is EditePostsCubitEroor) {
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
            if (state is EditePostsCubitSuccess) {
              Navigator.of(context).pushNamed(Routers.home);
            }
          },
          builder: (context, state) {
            var cubit = context.read<PostsCubitCubit>();
            return Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FromField(
                      controller: cubit.title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء ادخال العنوان ";
                        }
                        return null;
                      },
                      icon: Icon(Icons.abc, size: 25, color: Colors.black),
                      text: "العنوان ",
                      color: Color.fromARGB(255, 201, 199, 199),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 20),
                    FromField(
                      controller: cubit.content,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء ادخال المحتوى ";
                        }
                        return null;
                      },
                      icon: Icon(Icons.abc, size: 30, color: Colors.black),
                      text: "محتوى المنشور ",
                      color: Color.fromARGB(255, 201, 199, 199),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 15),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ButtonAuth(
                            text: ' تعديل المنشور',
                            function: () {
                              clickEdite(context);
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

void clickEdite(BuildContext context) {
  if (context.read<PostsCubitCubit>().key.currentState!.validate()) {
    context.read<PostsCubitCubit>().editePost();
  }
}
