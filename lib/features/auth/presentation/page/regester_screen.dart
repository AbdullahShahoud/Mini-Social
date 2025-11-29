import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/presentation/cubit/regester_cubit/cubit/regester_cubit_cubit.dart';
import 'package:social_app/features/auth/presentation/widget/button.dart';
import 'package:social_app/features/auth/presentation/widget/text_form_field.dart';
import '../../../../core/routing/router.dart';

class RegesterScreen extends StatefulWidget {
  const RegesterScreen({super.key});

  @override
  State<RegesterScreen> createState() => _LoginScreenState();
}

bool _isloading = false;

class _LoginScreenState extends State<RegesterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegesterCubitCubit, RegesterCubitState>(
          listener: (context, state) {
            if (state is RegesterCubitLoding) {
              _isloading = true;
            }
            if (state is RegesterCubitEroor) {
              _isloading = false;
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
                        Navigator.pushNamed(context, Routers.regester);
                      },
                    ),
                  ],
                ),
              );
            }
            if (state is RegesterCubitSuccess) {
              Navigator.of(context).pushNamed(Routers.home);
            }
          },
          builder: (context, state) {
            var cubit = context.read<RegesterCubitCubit>();
            return Form(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'انشاء الحساب',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    FromField(
                      controller: cubit.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء ادخال الاسم";
                        }
                        return null;
                      },
                      icon: Icon(Icons.abc, size: 25, color: Colors.black),
                      text: "الاسم",
                      color: Color.fromARGB(255, 201, 199, 199),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 20),
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
                          ' يوجد لديك حساب ؟',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 3),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(Routers.login);
                          },
                          child: Text(
                            'تسجيل الدخول',
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
                    _isloading
                        ? CircularProgressIndicator()
                        : ButtonAuth(
                            text: 'انشاء حساب',
                            function: () {
                              clickRegesiter(context);
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

void clickRegesiter(BuildContext context) {
  if (context.read<RegesterCubitCubit>().key.currentState!.validate()) {
    context.read<RegesterCubitCubit>().regester();
  }
}
// acvddd@gmail.comasdfghjklacvd