import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import 'package:social_app/features/auth/presentation/widget/button.dart';
import 'package:social_app/features/auth/presentation/widget/text_form_field.dart';

import '../../../../core/routing/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginCubitCubit, LoginCubitState>(
          listener: (context, state) {
            if (state is LoginCubitLoding) {
              _isLoading = true;
            }
            if (state is LoginCubitEroor) {
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
                        Navigator.pushNamed(context, Routers.login);
                      },
                    ),
                  ],
                ),
              );
            }
            if (state is LoginCubitSuccess) {
              Navigator.of(context).pushNamed(Routers.home);
            }
          },
          builder: (context, state) {
            var cubit = context.read<LoginCubitCubit>();
            return Form(
              key: cubit.key,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    FromField(
                      controller: cubit.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء ادخال البريد الاكتروني";
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.email_outlined,
                        size: 25,
                        color: Colors.black,
                      ),
                      text: "البريد الالكتروني",
                      color: Color.fromARGB(255, 201, 199, 199),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    FromField(
                      controller: cubit.password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء ادخال كلمة المرور";
                        }
                        return null;
                      },
                      obscure: cubit.obsure,
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            cubit.cnangeObscure();
                          });
                        },
                        icon: Icon(
                          cubit.obsure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      text: "كلمة المرور",
                      color: Color.fromARGB(255, 201, 199, 199),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لا يوجد لديك حساب ؟',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 3),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(Routers.regester);
                          },
                          child: Text(
                            'انشاء حساب',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ButtonAuth(
                            text: 'تسجيل الدخول',
                            function: () {
                              clickLogin(context);
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

void clickLogin(BuildContext context) {
  if (context.read<LoginCubitCubit>().key.currentState!.validate()) {
    context.read<LoginCubitCubit>().login();
  }
}
