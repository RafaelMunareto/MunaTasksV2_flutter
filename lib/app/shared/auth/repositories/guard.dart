// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';

class AuthGuard extends RouteGuard {
  final ILocalStorage storage = LocalStorageShare();
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    String token = '';

    await storage.get('token').then((value) {
      if (value != null) {
        token = value[0];
      } else {
        Modular.to.navigate('/auth/');
        return false;
      }
    });

    if (token != "") {
      return true;
    } else {
      Modular.to.navigate('/auth/');
      return false;
    }
  }
}
