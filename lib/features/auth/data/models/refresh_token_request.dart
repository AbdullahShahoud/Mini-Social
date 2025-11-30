import 'dart:convert';

class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  String toJsonString() {
    return jsonEncode({'refresh_token': refreshToken});
  }

  Map<String, dynamic> toJson() {
    return {'refresh_token': refreshToken};
  }
}
