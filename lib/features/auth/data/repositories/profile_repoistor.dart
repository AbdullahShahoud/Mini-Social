// lib/features/auth/data/repositories/login_repository.dart
import 'package:dartz/dartz.dart';
import 'package:social_app/core/error/errors.dart';
import '../../../../core/network/api_services.dart';
import '../models/profile_response.dart';

class ProfileRepo {
  final ApiService _apiService;

  ProfileRepo(this._apiService);

  Future<Either<Failure, ProfileResponseModel>> profile() async {
    return await _apiService.profile();
  }
}
