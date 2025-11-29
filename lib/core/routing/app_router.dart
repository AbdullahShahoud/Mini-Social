import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/routing/router.dart';
import 'package:social_app/features/posts/presentation/cubit/cubit/posts_cubit_cubit.dart';

import '../../features/auth/presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import '../../features/auth/presentation/cubit/regester_cubit/cubit/regester_cubit_cubit.dart';
import '../../features/posts/presentation/page/create_post.dart';
import '../../features/posts/presentation/page/edite_post.dart';
import '../../features/posts/presentation/page/home.dart';
import '../../features/auth/presentation/page/login_screen.dart';
import '../../features/auth/presentation/page/regester_screen.dart';
import '../services/injection.dart';

class AppRouter {
  static Route? ongeneratingRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.regester:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegesterCubitCubit(getIt(), getIt(), getIt()),
            child: RegesterScreen(),
          ),
        );
      case Routers.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubitCubit(getIt(), getIt()),
            child: LoginScreen(),
          ),
        );
      case Routers.home:
        return MaterialPageRoute(builder: (context) => Home());
      case Routers.editePosts:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                PostsCubitCubit(getIt(), getIt(), getIt(), getIt()),
            child: EditePost(),
          ),
        );
      case Routers.createPosts:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                PostsCubitCubit(getIt(), getIt(), getIt(), getIt()),
            child: CreatePosts(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Page Not Found')),
            body: Center(child: Text('The requested page was not found.')),
          ),
        );
    }
  }
}
