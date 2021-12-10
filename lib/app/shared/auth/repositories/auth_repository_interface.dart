abstract class IAuthRepository {
  getUser();
  getGoogleLogin();
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
