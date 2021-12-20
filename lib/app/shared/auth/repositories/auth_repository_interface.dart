import 'package:munatasks2/app/shared/auth/model/user_model.dart';

abstract class IAuthRepository {
  getUser();
  getGoogleLogin();
  Stream<List<UserModel>> getUsers();
  Future getFacebookLogin();
  Future getEmailPasswordLogin(email, password);
  Future sendChangePasswordEmail(email);
  Future changeResetPassword(password, code);
  Future<String> getToken();
  Future getLogout();
  Future createUserSendEmailLink(name, email, password);
  Future createUserEmailPassword(name, email, password);
  Future getGrupoEmail();
  Future emailVerify(code);
}
