
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';

class AuthGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    return Modular.get<AuthController>().usuarioNaoLogado();
  }
}