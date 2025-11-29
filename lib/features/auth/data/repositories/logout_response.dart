// lib/features/auth/data/repositories/login_repository.dart
import 'package:dartz/dartz.dart';
import 'package:social_app/core/error/errors.dart';
import '../../../../core/network/api_services.dart';
import '../models/logout_response.dart';

class LogoutRepo {
  final ApiService _apiService;

  LogoutRepo(this._apiService);

  Future<Either<Failure, LogoutResponse>> logout() async {
    return await _apiService.logout();
  }
}
