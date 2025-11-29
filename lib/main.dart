import 'package:flutter/material.dart';
import 'package:social_app/core/routing/app_router.dart';
import 'package:social_app/core/routing/router.dart';
import 'package:social_app/core/services/injection.dart';

import 'core/services/secure_storage.dart';

bool islogin = false;
selectRouter() async {
  String? token = await StorageToken.getSecureString('token');
  print(token);
  if (token == null || token == "") {
    islogin = false;
  } else {
    islogin = true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await selectRouter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: AppRouter.ongeneratingRoute,
      initialRoute: islogin ? Routers.home : Routers.regester,
    );
  }
}
