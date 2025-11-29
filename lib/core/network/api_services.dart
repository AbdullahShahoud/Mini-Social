// lib/core/services/api_service.dart
import 'package:dartz/dartz.dart';
import 'package:social_app/core/constant/api_constant.dart';
import 'package:social_app/core/error/errors.dart';
import 'package:social_app/features/auth/data/models/login_request.dart';
import 'package:social_app/features/auth/data/models/login_response.dart';
import 'package:social_app/features/auth/data/models/register_request.dart';
import 'package:social_app/features/auth/data/models/register_response.dart';
import '../../features/auth/data/models/logout_response.dart';
import '../../features/auth/data/models/profile_response.dart';
import '../../features/auth/data/models/refresh_token_request.dart';
import '../../features/auth/data/models/refresh_token_response.dart';
import '../../features/posts/data/models/delete_post_response.dart';
import '../../features/posts/data/models/posts_Feed_Response.dart';
import '../../features/posts/data/models/update_post_reguest.dart';
import 'dio_service.dart';

class ApiService {
  final DioServicies _dioService;

  ApiService(this._dioService);

  Future<Either<Failure, LoginResponse>> login(
    LoginRequest loginRequest,
  ) async {
    final response = await _dioService.post(
      endpoint: ApiConstant.login,
      body: loginRequest.toJson(),
      fromJson: (json) => LoginResponse.fromJson(json),
    );
    return response;
  }

  Future<Either<Failure, RegisterResponse>> register(
    RegisterRequest registerRequest,
  ) async {
    final response = await _dioService.post(
      endpoint: ApiConstant.register,
      rawBody: registerRequest.toJsonString(),
      fromJson: (json) => RegisterResponse.fromJson(json),
    );
    return response;
  }

  Future<Either<Failure, RefreshTokenResponse>> rferchToken(
    RefreshTokenRequest refreshTokenRequest,
  ) async {
    final response = await _dioService.post(
      endpoint: ApiConstant.token_refresh,
      body: refreshTokenRequest.toJson(),
      fromJson: (json) => RefreshTokenResponse.fromJson(json),
    );
    return response;
  }

  Future<Either<Failure, LogoutResponse>> logout() async {
    final response = await _dioService.post(
      endpoint: ApiConstant.logout,
      fromJson: (json) => LogoutResponse.fromJson(json),
    );
    return response;
  }

  Future<Either<Failure, ProfileResponseModel>> profile() async {
    final response = await _dioService.get(
      endpoint: ApiConstant.me,
      fromJson: (json) => ProfileResponseModel.fromJson(json),
    );
    return response;
  }

  Future<Either<Failure, PostsResponseModel>> getPosts({
    int perPage = 2,
    String search = "",
    String mediaType = "",
  }) async {
    final response = await _dioService.get(
      endpoint: ApiConstant.posts,
      queryParameters: {
        'per_page': perPage,
        'search': search,
        'media_type': mediaType,
      },
      fromJson: (json) => PostsResponseModel.fromJson(json),
    );
    return response;
  }

  Future<Either<Failure, DeletePostResponse>> deletePosts(int id) async {
    final response = await _dioService.delete(
      endpoint: ApiConstant.posts,
      queryParameters: {'id': id},
      fromJson: (json) => DeletePostResponse.fromJson(json),
    );
    return response;
  }

  Future<Either<Failure, PostsResponseModel>> editePosts(
    UpdatePostRequest updatePostRequest,
    int id,
  ) async {
    final response = await _dioService.put(
      body: updatePostRequest.toJson(),
      queryParameters: {'id': id},
      endpoint: ApiConstant.posts,
      fromJson: (json) => PostsResponseModel.fromJson(json),
    );
    return response;
  }
}
