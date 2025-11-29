// lib/features/auth/data/repositories/login_repository.dart
import 'package:dartz/dartz.dart';
import 'package:social_app/core/error/errors.dart';
import 'package:social_app/features/posts/data/models/update_post_reguest.dart';
import '../../../../core/network/api_services.dart';
import '../models/posts_Feed_Response.dart';

class EditePostsRepo {
  final ApiService _apiService;

  EditePostsRepo(this._apiService);

  Future<Either<Failure, PostsResponseModel>> editePosts(
    UpdatePostRequest updatePostRequest,
    int id,
  ) async {
    return await _apiService.editePosts(updatePostRequest, id);
  }
}
