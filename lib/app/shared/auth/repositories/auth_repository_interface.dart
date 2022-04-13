import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';

abstract class IAuthRepository {
  Future loginDio(email, password);
  Future sendEmailChangePassword(String email);
  Future changeUserPassword(String id, String password);
  Future saveUser(UserDioClientModel model);
  Future perfilUser(String user);
  getGoogleLogin();
  getUser();
  Future getFacebookLogin();
  Future getLogout();
}
