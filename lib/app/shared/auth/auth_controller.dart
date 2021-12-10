import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:munatasks2/app/shared/auth/repositories/biometric_repository_interface.dart';
import 'package:mobx/mobx.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final IAuthRepository authRepository;
  final IBiometricRepository biometricRepository;

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  User? user;

  _AuthControllerBase({required this.authRepository, required this.biometricRepository}){
   setUser(authRepository.getUser());
  }

  @action
  setUser(User? value) {
    user = value;
    status = user == null ? AuthStatus.logoff : AuthStatus.login;
  }

  @action
  Future loginWithGoogle() async {
    user = await authRepository.getGoogleLogin();
  }

  @action
  Future createUserLinkEmail(name, email, password)  {
     return authRepository.createUserSendEmailLink(name, email, password);
  }

  @action
  Future createUserEmailPassword(name, email, password)  {
    return authRepository.createUserEmailPassword(name, email, password);
  }

  @action
  Future getGrupoEmail()
  {
    return authRepository.getGrupoEmail();
  }

  @action
  Future getEmailPasswordLogin(email, password)
  {
    return authRepository.getEmailPasswordLogin(email, password);
  }

  @action
  Future sendChangePasswordEmail(email){
    return authRepository.sendChangePasswordEmail(email);
  }

  @action
  Future changeResetPassword(password, code)
  {
    return authRepository.changeResetPassword(password,code);
  }

  @action
  Future logout() {
    return authRepository.getLogout();
  }

  @action
  Future emailVerify(code)
  {
    return authRepository.emailVerify(code);
  }

  //controle de acesso
  @action
  usuarioNaoLogado()
  {
    setUser(authRepository.getUser());
    if(user == null){
     return Modular.to.navigate('/auth/');
    }
    return false;
  }

  //biometric
  @action
  Future checkBiometrics()
  {
    return biometricRepository.checkBiometrics();
  }
  @action
  Future getAvailableBiometrics()
  {
    return biometricRepository.getAvailableBiometrics();
  }

  @action
  Future<String> authenticateWithBiometrics(bool faceOrFinger)
  {
    return biometricRepository.authenticateWithBiometrics(faceOrFinger);
  }
  @action
  cancelAuthentication()
  {
    return biometricRepository.cancelAuthentication();
  }

}

enum AuthStatus { loading, login, logoff }
