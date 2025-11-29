import 'token_model.dart';
import 'user_model.dart';

class RefreshTokenResponse {
  final bool status;
  final String message;
  final RefreshTokenData data;

  RefreshTokenResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      status: json['status'],
      message: json['message'],
      data: RefreshTokenData.fromJson(json['data']),
    );
  }
}

class RefreshTokenData {
  final UserModel user;
  final TokensModel tokens;

  RefreshTokenData({required this.user, required this.tokens});

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) {
    return RefreshTokenData(
      user: UserModel.fromJson(json['user']),
      tokens: TokensModel.fromJson(json['tokens']),
    );
  }
}
