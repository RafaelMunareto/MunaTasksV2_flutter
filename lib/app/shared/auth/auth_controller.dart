import 'dart:convert';

import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:munatasks2/app/shared/auth/repositories/biometric_repository_interface.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final IAuthRepository authRepository;
  final ILocalStorage storage = LocalStorageShare();
  final IBiometricRepository biometricRepository;

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  UserDioClientModel? user;

  _AuthControllerBase(
      {required this.authRepository, required this.biometricRepository});

  @action
  setUser(UserDioClientModel value) {
    storage.get('userDio').then((value) {
      if (value != null) {
        user = UserDioClientModel.fromJson(jsonDecode(value[0])['user']);
      }
    });
    status = user!.id == null ? AuthStatus.logoff : AuthStatus.login;
  }

  @action
  Future loginWithGoogle() {
    return authRepository.getGoogleLogin();
  }

  @action
  logout() {
    return authRepository.getLogout();
  }

  //biometric
  @action
  Future checkBiometrics() {
    return biometricRepository.checkBiometrics();
  }

  @action
  Future getAvailableBiometrics() {
    return biometricRepository.getAvailableBiometrics();
  }

  @action
  Future<String> authenticateWithBiometrics(bool faceOrFinger) {
    return biometricRepository.authenticateWithBiometrics(faceOrFinger);
  }

  @action
  cancelAuthentication() {
    return biometricRepository.cancelAuthentication();
  }

  @action
  Future getLoginDio(email, password) {
    return authRepository.loginDio(email, password);
  }

  @action
  saveUser(UserDioClientModel model) {
    return authRepository.saveUser(model);
  }

  @action
  Future perfilUser(UserDioClientModel user) {
    return authRepository.perfilUser(user);
  }

  @action
  Future sendEmailChangePassword(String email) {
    return authRepository.sendEmailChangePassword(email);
  }

  @action
  Future changeUserPassword(String id, String password) {
    return authRepository.changeUserPassword(id, password);
  }
}

enum AuthStatus { loading, login, logoff }
