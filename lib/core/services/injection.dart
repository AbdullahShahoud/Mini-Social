// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:social_app/core/error/erorr_handler.dart';
import 'package:social_app/core/network/api_services.dart';
import 'package:social_app/core/network/dio_service.dart';
import 'package:social_app/features/auth/data/repositories/Login_repoistor.dart';
import 'package:social_app/features/auth/presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import 'package:social_app/features/auth/presentation/cubit/regester_cubit/cubit/regester_cubit_cubit.dart';

import '../../features/auth/data/repositories/logout_response.dart';
import '../../features/auth/data/repositories/profile_repoistor.dart';
import '../../features/auth/data/repositories/referch_token_repoistor.dart';
import '../../features/auth/data/repositories/regester_repoistor.dart';
import '../../features/posts/data/repositories/create_post_repositries.dart';
import '../../features/posts/data/repositories/delete_post_repositries.dart';
import '../../features/posts/data/repositories/edit_post_repositries.dart';
import '../../features/posts/data/repositories/get_posts_repositories.dart';
import '../../features/posts/presentation/cubit/cubit/posts_cubit_cubit.dart';
import '../constant/api_constant.dart';
import 'secure_storage.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<ErrorHandlerService>(() => ErrorHandlerService());
  getIt.registerLazySingleton(
    () => DioServicies(
      baseUrl: ApiConstant.basieUrl,
      errorHandler: getIt(),
      defaultHeaders: {
        'Authorization': 'Bearer ${StorageToken.getSecureString('token')}',
      },
    ),
  );
  // المستودعات
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt()));
  getIt.registerFactory(() => LoginCubitCubit(getIt(), getIt()));
  getIt.registerFactory(
    () => PostsCubitCubit(getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerFactory(() => RegesterCubitCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => ProfileRepo(getIt()));
  getIt.registerFactory(() => RegesterRepoistor(getIt()));
  getIt.registerFactory(() => LoginRepo(getIt()));
  getIt.registerFactory(() => LogoutRepo(getIt()));
  getIt.registerFactory(() => ReferchTokenRepo(getIt()));
  getIt.registerFactory(() => GetPostsRepo(getIt()));
  getIt.registerFactory(() => DeletePostsRepo(getIt()));
  getIt.registerFactory(() => EditePostsRepo(getIt()));
  getIt.registerFactory(() => CreatePostsRepo());
  // // حالات البلوك
  // getIt.registerFactory(() => UserCubit(userRepository: getIt()));
  // getIt.registerFactory(() => ProductCubit(productRepository: getIt()));
}
