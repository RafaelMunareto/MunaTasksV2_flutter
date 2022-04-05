abstract class IAuthRepository {
  Future loginDio(email, password);
  getGoogleLogin();
  getUser();
  Future getFacebookLogin();
  Future getLogout();
}
