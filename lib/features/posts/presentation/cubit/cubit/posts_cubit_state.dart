part of 'posts_cubit_cubit.dart';

@immutable
sealed class PostsCubitState {}

final class PostsCubitInitial extends PostsCubitState {}

final class GetPostsCubitLoding extends PostsCubitState {}

final class GetPostsCubitEroor extends PostsCubitState {
  final String massege;
  GetPostsCubitEroor(this.massege);
}

final class GetPostsCubitSuccess extends PostsCubitState {
  final PostsResponseModel postsResponseModel;

  GetPostsCubitSuccess(this.postsResponseModel);
}

final class DeletePostsCubitLoding extends PostsCubitState {}

final class DeletePostsCubitEroor extends PostsCubitState {
  final String massege;
  DeletePostsCubitEroor(this.massege);
}

final class DeletePostsCubitSuccess extends PostsCubitState {
  final DeletePostResponse deletePostResponse;

  DeletePostsCubitSuccess(this.deletePostResponse);
}

final class EditePostsCubitLoding extends PostsCubitState {}

final class EditePostsCubitEroor extends PostsCubitState {
  final String massege;
  EditePostsCubitEroor(this.massege);
}

final class EditePostsCubitSuccess extends PostsCubitState {
  final PostsResponseModel postsResponseModel;

  EditePostsCubitSuccess(this.postsResponseModel);
}

final class CreatePostsCubitLoding extends PostsCubitState {}

final class CreatePostsCubitEroor extends PostsCubitState {
  final String massege;
  CreatePostsCubitEroor(this.massege);
}

final class CreatePostsCubitSuccess extends PostsCubitState {
  final CreatePostResponseModel createPostResponseModel;

  CreatePostsCubitSuccess(this.createPostResponseModel);
}
