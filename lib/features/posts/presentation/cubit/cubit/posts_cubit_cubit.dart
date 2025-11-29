import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/features/posts/data/repositories/get_posts_repositories.dart';

import '../../../data/models/create_post_reguest.dart';
import '../../../data/models/create_post_response.dart';
import '../../../data/models/delete_post_response.dart';
import '../../../data/models/posts_Feed_Response.dart';
import '../../../data/models/update_post_reguest.dart';
import '../../../data/repositories/create_post_repositries.dart';
import '../../../data/repositories/delete_post_repositries.dart';
import '../../../data/repositories/edit_post_repositries.dart';

part 'posts_cubit_state.dart';

class PostsCubitCubit extends Cubit<PostsCubitState> {
  PostsCubitCubit(
    this._getPostsRepo,
    this._deletePostsRepo,
    this._editePostsRepo,
    this._createPostsRepo,
  ) : super(PostsCubitInitial());
  GetPostsRepo _getPostsRepo;
  DeletePostsRepo _deletePostsRepo;
  EditePostsRepo _editePostsRepo;
  CreatePostsRepo _createPostsRepo;
  static PostsCubitCubit get(context) => BlocProvider.of(context);
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  var key = GlobalKey<FormState>();
  PostsResponseModel? posts;
  int? selectEdit;
  int? selectdelet;
  Future<void> getPosts({
    int perPage = 2,
    String search = "",
    String mediaType = "",
  }) async {
    if (isClosed) return;

    emit(GetPostsCubitLoding());

    final response = await _getPostsRepo.getPosts(
      perPage: perPage,
      search: search,
      mediaType: mediaType,
    );

    if (isClosed) return;

    response.fold((failure) => emit(GetPostsCubitEroor(failure.message)), (
      postsResponse,
    ) {
      print('✅ ✅✅✅');
      emit(GetPostsCubitSuccess(postsResponse));
      posts = postsResponse;
    });
  }

  Future<void> deletePost() async {
    emit(DeletePostsCubitLoding());
    final response = await _deletePostsRepo.deletePosts(selectdelet!);
    response.fold((failure) => emit(DeletePostsCubitEroor(failure.message)), (
      deletePostResponse,
    ) async {
      emit(DeletePostsCubitSuccess(deletePostResponse));
    });
  }

  Future<void> editePost() async {
    emit(EditePostsCubitLoding());
    final response = await _editePostsRepo.editePosts(
      UpdatePostRequest(title: title.text, content: content.text),
      selectEdit!,
    );
    response.fold((failure) => emit(EditePostsCubitEroor(failure.message)), (
      editePostResponse,
    ) async {
      emit(EditePostsCubitSuccess(editePostResponse));
    });
  }

  Future<void> createPost(
    String title,
    String content,
    List<String> mediaFiles,
  ) async {
    emit(CreatePostsCubitLoding());
    final response = await _createPostsRepo.createPosts(
      CreatePostRequest(title: title, content: content, mediaFiles: mediaFiles),
    );
    response.fold((failure) => emit(CreatePostsCubitEroor(failure.message)), (
      createPostResponse,
    ) async {
      emit(CreatePostsCubitSuccess(createPostResponse));
    });
  }
}
