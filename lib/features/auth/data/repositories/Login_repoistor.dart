// lib/features/auth/data/repositories/login_repository.dart
import 'package:dartz/dartz.dart';
import 'package:social_app/core/error/errors.dart';
import '../../../../core/network/api_services.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class LoginRepo {
  final ApiService _apiService;

  LoginRepo(this._apiService);

  Future<Either<Failure, LoginResponse>> login(
    LoginRequest loginRequest,
  ) async {
    return await _apiService.login(loginRequest);
  }
}
