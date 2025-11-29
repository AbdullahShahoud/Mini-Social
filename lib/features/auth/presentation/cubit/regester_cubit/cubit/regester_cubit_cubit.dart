import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_app/features/auth/data/repositories/logout_response.dart';

import '../../../../../../core/services/secure_storage.dart';
import '../../../../data/models/logout_response.dart';
import '../../../../data/models/profile_response.dart';
import '../../../../data/models/register_request.dart';
import '../../../../data/models/register_response.dart';
import '../../../../data/repositories/profile_repoistor.dart';
import '../../../../data/repositories/regester_repoistor.dart';

part 'regester_cubit_state.dart';

class RegesterCubitCubit extends Cubit<RegesterCubitState> {
  RegesterCubitCubit(
    this._regesterRepoistor,
    this._logoutRepo,
    this._profileRepo,
  ) : super(RegesterCubitInitial());
  RegesterRepoistor _regesterRepoistor;
  LogoutRepo _logoutRepo;
  ProfileRepo _profileRepo;
  var key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obsure = false;
  void cnangeObscure() {
    obsure = !obsure;
  }

  String nametext = '';
  String emailtext = '';
  Future<void> regester() async {
    emit(RegesterCubitLoding());
    final response = await _regesterRepoistor.register(
      RegisterRequest(
        email: email.text,
        password: password.text,
        name: name.text,
      ),
    );
    response.fold((failure) => emit(RegesterCubitEroor(failure.message)), (
      registerResponse,
    ) {
      StorageToken.setSecureString(
        'token',
        registerResponse.data.tokens.accessToken,
      );
      StorageToken.setSecureString(
        'refresh_token',
        registerResponse.data.tokens.refreshToken,
      );
      emit(RegesterCubitSuccess(registerResponse));
    });
  }

  Future<void> logout() async {
    emit(LogoutCubitLoding());
    final response = await _logoutRepo.logout();
    response.fold((failure) => emit(LogoutCubitEroor(failure.message)), (
      logoutResponse,
    ) {
      StorageToken.clearAllSecuredData();
      emit(LogoutCubitSuccess(logoutResponse));
    });
  }

  Future<void> profile() async {
    emit(ProfileCubitLoding());
    final response = await _profileRepo.profile();
    response.fold((failure) => emit(ProfileCubitEroor(failure.message)), (
      profileResponse,
    ) {
      emit(ProfileCubitSuccess(profileResponse));
      nametext = profileResponse.data.name;
      emailtext = profileResponse.data.email;
    });
  }
}
