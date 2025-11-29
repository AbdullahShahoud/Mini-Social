part of 'regester_cubit_cubit.dart';

@immutable
sealed class RegesterCubitState {}

final class RegesterCubitInitial extends RegesterCubitState {}

final class RegesterCubitLoding extends RegesterCubitState {}

final class RegesterCubitEroor extends RegesterCubitState {
  final String massege;
  RegesterCubitEroor(this.massege);
}

final class RegesterCubitSuccess extends RegesterCubitState {
  final RegisterResponse registerResponse;

  RegesterCubitSuccess(this.registerResponse);
}

final class LogoutCubitLoding extends RegesterCubitState {}

final class LogoutCubitEroor extends RegesterCubitState {
  final String massege;
  LogoutCubitEroor(this.massege);
}

final class LogoutCubitSuccess extends RegesterCubitState {
  final LogoutResponse logoutResponse;

  LogoutCubitSuccess(this.logoutResponse);
}

final class ProfileCubitLoding extends RegesterCubitState {}

final class ProfileCubitEroor extends RegesterCubitState {
  final String massege;
  ProfileCubitEroor(this.massege);
}

final class ProfileCubitSuccess extends RegesterCubitState {
  final ProfileResponseModel profileResponseModel;

  ProfileCubitSuccess(this.profileResponseModel);
}
