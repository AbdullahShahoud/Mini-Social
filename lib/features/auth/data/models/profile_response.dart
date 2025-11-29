class ProfileResponseModel {
  final bool status;
  final String message;
  final UserData data;

  ProfileResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class UserData {
  final int id;
  final String name;
  final String email;

  UserData({required this.id, required this.name, required this.email});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(id: json['id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
