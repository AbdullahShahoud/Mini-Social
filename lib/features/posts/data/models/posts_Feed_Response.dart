import '../../../auth/data/models/user_model.dart';

class PostsResponseModel {
  final bool status;
  final String message;
  final PostsData data;

  PostsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PostsResponseModel.fromJson(Map<String, dynamic> json) {
    return PostsResponseModel(
      status: json['status'],
      message: json['message'],
      data: PostsData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class PostsData {
  final List<PostModel> posts;
  final PaginationModel pagination;

  PostsData({required this.posts, required this.pagination});

  factory PostsData.fromJson(Map<String, dynamic> json) {
    return PostsData(
      posts: (json['posts'] as List)
          .map((item) => PostModel.fromJson(item))
          .toList(),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posts': posts.map((item) => item.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class PaginationModel {
  final int currentPage;
  final int perPage;
  final int total;
  final int lastPage;

  PaginationModel({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.lastPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'],
      perPage: json['per_page'],
      total: json['total'],
      lastPage: json['last_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'total': total,
      'last_page': lastPage,
    };
  }
}

class PostModel {
  final int id;
  final String title;
  final String content;
  final UserModel user;
  final List<MediaModel> media;
  final String createdAt;
  final String updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.user,
    required this.media,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      user: UserModel.fromJson(json['user']),
      media: (json['media'] as List)
          .map((item) => MediaModel.fromJson(item))
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

class MediaModel {
  final int id;
  final String mediaType;
  final String url;
  final String filePath;

  MediaModel({
    required this.id,
    required this.mediaType,
    required this.url,
    required this.filePath,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
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
