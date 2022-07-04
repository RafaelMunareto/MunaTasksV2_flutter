import 'package:dio/dio.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';

abstract class IAuthRepository {
  Future loginDio(email, password);
  Future sendEmailChangePassword(String email);
  Future changeUserPassword(String id, String password);
  Future saveUser(UserDioClientModel model);
  Future perfilUser(UserDioClientModel user);
  Future getGoogleLogin();
  getUser();
  Future getFacebookLogin();
  getLogout();
  globalError(DioError error);
}
