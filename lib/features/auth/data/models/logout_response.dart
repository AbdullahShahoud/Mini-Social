class LogoutResponse {
  final String message;
  final bool status;
  // final dynamic data;

  const LogoutResponse({
    required this.message,
    required this.status,
    // required this.data,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      status: json['status'],
      message: json['message'],
      // data: json['data'],
    );
  }
}
