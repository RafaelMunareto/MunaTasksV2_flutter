import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class AuthGuard extends RouteGuard {
  @override
  // ignore: avoid_renaming_method_parameters
  Future<bool> canActivate(String path, ModularRoute router) async {
    bool token = false;
    await SessionManager().containsKey("token").then((value) {
      value ? token = true : token = false;
    });

    if (token) {
      return true;
    } else {
      Modular.to.navigate('/auth/');
      return false;
    }
  }
}
