import '../../../auth/data/models/login_response.dart';

class DeletePostResponse {
  final String message;
  final bool status;
  final AuthData? data;
  const DeletePostResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DeletePostResponse.fromJson(Map<String, dynamic> json) {
    return DeletePostResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? json['data'] : ' ',
    );
  }
}
