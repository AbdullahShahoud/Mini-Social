// create_post_response.dart
class CreatePostResponseModel {
  final bool status;
  final String message;
  final CreatedPostData data;

  CreatePostResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreatePostResponseModel.fromJson(Map<String, dynamic> json) {
    return CreatePostResponseModel(
      status: json['status'],
      message: json['message'],
      data: CreatedPostData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class CreatedPostData {
  final int id;
  final String title;
  final String content;
  final PostUser user;
  final List<PostMedia> media;
  final String createdAt;
  final String updatedAt;

  CreatedPostData({
    required this.id,
    required this.title,
    required this.content,
    required this.user,
    required this.media,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatedPostData.fromJson(Map<String, dynamic> json) {
    return CreatedPostData(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      user: PostUser.fromJson(json['user']),
      media: (json['media'] as List)
          .map((item) => PostMedia.fromJson(item))
          .toList(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user': user.toJson(),
      'media': media.map((item) => item.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PostUser {
  final int id;
  final String name;
  final String email;

  PostUser({required this.id, required this.name, required this.email});

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(id: json['id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}

class PostMedia {
  final int id;
  final String mediaType;
  final String url;
  final String filePath;

  PostMedia({
    required this.id,
    required this.mediaType,
    required this.url,
    required this.filePath,
  });

  factory PostMedia.fromJson(Map<String, dynamic> json) {
    return PostMedia(
      id: json['id'],
      mediaType: json['media_type'],
      url: json['url'],
      filePath: json['file_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'media_type': mediaType,
      'url': url,
      'file_path': filePath,
    };
  }
}
