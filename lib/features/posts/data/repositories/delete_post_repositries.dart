// lib/features/auth/data/repositories/login_repository.dart
import 'package:dartz/dartz.dart';
import 'package:social_app/core/error/errors.dart';
import '../../../../core/network/api_services.dart';
import '../models/delete_post_response.dart';

class DeletePostsRepo {
  final ApiService _apiService;

  DeletePostsRepo(this._apiService);

  Future<Either<Failure, DeletePostResponse>> deletePosts(int id) async {
    return await _apiService.deletePosts(id);
  }
}
