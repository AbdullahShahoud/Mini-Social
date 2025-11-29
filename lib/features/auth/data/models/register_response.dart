import 'token_model.dart';
import 'user_model.dart';

class RegisterResponse {
  final bool status;
  final String message;
  final AuthData data;

  RegisterResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'],
      message: json['message'],
      data: AuthData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class AuthData {
  final UserModel user;
  final TokensModel tokens;

  AuthData({required this.user, required this.tokens});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      user: UserModel.fromJson(json['user']),
      tokens: TokensModel.fromJson(json['tokens']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'tokens': tokens.toJson()};
  }
}
