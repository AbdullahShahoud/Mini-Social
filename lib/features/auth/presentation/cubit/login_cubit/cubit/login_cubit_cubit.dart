import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:social_app/features/auth/data/models/login_request.dart';
import 'package:social_app/features/auth/data/models/refresh_token_request.dart';
import 'package:social_app/features/auth/data/repositories/Login_repoistor.dart';

import '../../../../../../core/services/secure_storage.dart';
import '../../../../data/models/login_response.dart';
import '../../../../data/models/refresh_token_response.dart';
import '../../../../data/repositories/referch_token_repoistor.dart';

part 'login_cubit_state.dart';

class LoginCubitCubit extends Cubit<LoginCubitState> {
  LoginCubitCubit(this._loginRepo, this._referchTokenRepo)
    : super(LoginCubitInitial());
  LoginRepo _loginRepo;
  ReferchTokenRepo _referchTokenRepo;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var key = GlobalKey<FormState>();
  bool obsure = false;
  void cnangeObscure() {
    obsure = !obsure;
  }

  Future<void> login() async {
    emit(LoginCubitLoding());
    final response = await _loginRepo.login(
      LoginRequest(email: email.text, password: password.text),
    );
    response.fold((failure) => emit(LoginCubitEroor(failure.message)), (
      loginResponse,
    ) async {
      emit(LoginCubitSuccess(loginResponse));
      await StorageToken.setSecureString(
        'token',
        loginResponse.data.tokens.accessToken,
      );
      StorageToken.setSecureString(
        'refresh_token',
        loginResponse.data.tokens.refreshToken,
      );
    });
  }

  Future<void> referacheToken() async {
    emit(ReferachTokenCubitLoding());
    var token = await StorageToken.getSecureString('token');
    final response = await _referchTokenRepo.rferchToken(
      RefreshTokenRequest(refreshToken: token!),
    );
    response.fold((failure) => emit(ReferachTokenCubitEroor(failure.message)), (
      referachTokenResponse,
    ) async {
      emit(ReferachTokenCubitSuccess(referachTokenResponse));
      await StorageToken.setSecureString(
        'token',
        referachTokenResponse.data.tokens.accessToken,
      );
      StorageToken.setSecureString(
        'refresh_token',
        referachTokenResponse.data.tokens.refreshToken,
      );
    });
  }
}
