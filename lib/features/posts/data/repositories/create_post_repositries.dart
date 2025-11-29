import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:social_app/core/error/errors.dart';

import '../../../../core/constant/api_constant.dart';
import '../../../../core/services/secure_storage.dart';
import '../models/create_post_reguest.dart';
import '../models/create_post_response.dart';

class CreatePostsRepo {
  Future<Either<Failure, CreatePostResponseModel>> createPosts(
    CreatePostRequest createPostRequest,
  ) async {
    try {
      final dio = Dio();
      final formData = await createPostRequest.toFormData();
      final token = await StorageToken.getSecureString('token') ?? '';

      final response = await dio.post(
        '${ApiConstant.basieUrl}/posts',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 201) {
        return Right(CreatePostResponseModel.fromJson(response.data));
      } else {
        return Left(ServerFailure('خطأ: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(ServerFailure('فشل في إنشاء المنشور: $e'));
    }
  }
}
