// lib/features/auth/data/repositories/login_repository.dart
import 'package:dartz/dartz.dart';
import 'package:social_app/core/error/errors.dart';
import 'package:social_app/features/auth/data/models/register_request.dart';
import 'package:social_app/features/auth/data/models/register_response.dart';
import '../../../../core/network/api_services.dart';

class RegesterRepoistor {
  final ApiService _apiService;

  RegesterRepoistor(this._apiService);

  Future<Either<Failure, RegisterResponse>> register(
    RegisterRequest registerRequest,
  ) async {
    return await _apiService.register(registerRequest);
  }
}
