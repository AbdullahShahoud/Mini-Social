part of 'login_cubit_cubit.dart';

@immutable
sealed class LoginCubitState {}

final class LoginCubitInitial extends LoginCubitState {}

final class LoginCubitLoding extends LoginCubitState {}

final class LoginCubitEroor extends LoginCubitState {
  final String massege;
  LoginCubitEroor(this.massege);
}

final class LoginCubitSuccess extends LoginCubitState {
  final LoginResponse loginResponse;

  LoginCubitSuccess(this.loginResponse);
}

final class ReferachTokenCubitLoding extends LoginCubitState {}

final class ReferachTokenCubitEroor extends LoginCubitState {
  final String massege;
  ReferachTokenCubitEroor(this.massege);
}

final class ReferachTokenCubitSuccess extends LoginCubitState {
  final RefreshTokenResponse refreshTokenResponse;

  ReferachTokenCubitSuccess(this.refreshTokenResponse);
}
