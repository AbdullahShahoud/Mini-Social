class UpdatePostRequest {
  final String title;
  final String content;
  final List<int> removeMediaIds;
  final List<String> newMediaFiles;

  UpdatePostRequest({
    required this.title,
    required this.content,
    this.removeMediaIds = const [],
    this.newMediaFiles = const [],
  });
  factory UpdatePostRequest.fromJson(Map<String, dynamic> json) {
    return UpdatePostRequest(
      title: json['title'],
      content: json['content'],
      removeMediaIds: json['removeMediaIds'] != null ? json['data'] : ' ',
      newMediaFiles: json['newMediaFiles'] != null ? json['data'] : ' ',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'removeMediaIds': removeMediaIds,
      'newMediaFiles': newMediaFiles,
    };
  }
}
