class TokensModel {
  final String tokenType;
  final String accessToken;
  final String accessTokenExpiresAt;
  final String refreshToken;
  final String refreshTokenExpiresAt;

  TokensModel({
    required this.tokenType,
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.refreshToken,
    required this.refreshTokenExpiresAt,
  });
  // اذا كان الtoken يعيد كل هذا
  // ايها اخزن ك token
  //   final String tokenType;
  //   final String accessToken;
  //   final String accessTokenExpiresAt;
  //   final String refreshToken;
  //   final String refreshTokenExpiresAt;
  factory TokensModel.fromJson(Map<String, dynamic> json) {
    return TokensModel(
      tokenType: json['token_type'],
      accessToken: json['access_token'],
      accessTokenExpiresAt: json['access_token_expires_at'],
      refreshToken: json['refresh_token'],
      refreshTokenExpiresAt: json['refresh_token_expires_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token_type': tokenType,
      'access_token': accessToken,
      'access_token_expires_at': accessTokenExpiresAt,
      'refresh_token': refreshToken,
      'refresh_token_expires_at': refreshTokenExpiresAt,
    };
  }
}
