import 'package:dio/dio.dart';

class CreatePostRequest {
  final String title;
  final String content;
  final List<String> mediaFiles;

  CreatePostRequest({
    required this.title,
    required this.content,
    required this.mediaFiles,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry('title', title),
      MapEntry('content', content),
    ]);
    for (var filePath in mediaFiles) {
      if (filePath.isNotEmpty) {
        formData.files.add(
          MapEntry('media[]', await MultipartFile.fromFile(filePath)),
        );
      }
    }
    return formData;
  }
}
