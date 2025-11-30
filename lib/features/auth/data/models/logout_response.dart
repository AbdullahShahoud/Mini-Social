class LogoutResponse {
  final String message;
  final bool status;

  const LogoutResponse({required this.message, required this.status});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(status: json['status'], message: json['message']);
  }
}
