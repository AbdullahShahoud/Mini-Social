import 'package:dartz/dartz.dart';
import 'package:social_app/core/error/errors.dart';

import '../../../../core/network/api_services.dart';
import '../models/posts_Feed_Response.dart';

class GetPostsRepo {
  final ApiService _apiService;

  GetPostsRepo(this._apiService);

  Future<Either<Failure, PostsResponseModel>> getPosts({
    int perPage = 10,
    String search = "",
    String mediaType = "",
  }) async {
    return await _apiService.getPosts(
      perPage: perPage,
      search: search,
      mediaType: mediaType,
    );
  }
}
