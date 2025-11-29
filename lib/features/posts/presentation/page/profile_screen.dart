// ignore_for_file: must_be_immutable, empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/routing/router.dart';
import 'package:social_app/core/services/injection.dart';

import '../../../auth/presentation/cubit/regester_cubit/cubit/regester_cubit_cubit.dart';
import '../../../auth/presentation/widget/button.dart';

List<Item> items = [
  Item(Icons.settings, 'الاعدادات'),
  Item(Icons.help, 'المساعدة'),
  Item(Icons.language, 'اللغات'),
];

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            RegesterCubitCubit(getIt(), getIt(), getIt())..profile(),
        child: BlocConsumer<RegesterCubitCubit, RegesterCubitState>(
          listener: (context, state) {
            if (state is LogoutCubitLoding) {
              _isloading = true;
            }
            if (state is LogoutCubitSuccess) {
              Navigator.pushNamed(context, Routers.login);
            }
            if (state is LogoutCubitEroor) {
              _isloading = false;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Container(
                    height: 60,
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
          },
          builder: (context, state) {
            var cubit = context.read<RegesterCubitCubit>();
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 25,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'الملف الشخصي',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Text(
                                'cubit.nametext',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                'cubit.emailtext',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color.fromARGB(
                                    255,
                                    107,
                                    104,
                                    104,
                                  ),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 12),
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(
                              'assets/images/persoin.jfif',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 250,
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            height: 60,
                            width: 180,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 201, 199, 199),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_back),
                                ),
                                Spacer(),
                                Text(
                                  items[index].name!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Container(
                                  height: 60,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(child: Icon(items[index].icon)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    _isloading
                        ? CircularProgressIndicator()
                        : InkWell(
                            onTap: () {
                              cubit.logout();
                            },
                            child: Icon(
                              Icons.logout_rounded,
                              size: 35,
                              color: Colors.red,
                            ),
                          ),
                    SizedBox(height: 20),
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

class Item {
  String? name;
  IconData? icon;
  Item(this.icon, this.name);
}
