// lib/features/auth/data/repositories/login_repository.dart
import 'package:dartz/dartz.dart';
import 'package:social_app/core/error/errors.dart';
import '../../../../core/network/api_services.dart';
import '../models/refresh_token_request.dart';
import '../models/refresh_token_response.dart';

class ReferchTokenRepo {
  final ApiService _apiService;

  ReferchTokenRepo(this._apiService);

  Future<Either<Failure, RefreshTokenResponse>> rferchToken(
    RefreshTokenRequest refreshTokenRequest,
  ) async {
    return await _apiService.rferchToken(refreshTokenRequest);
  }
}
