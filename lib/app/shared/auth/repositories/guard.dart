// ignore_for_file: avoid_renaming_method_parameters

import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';

class AuthGuard extends RouteGuard {
  final ILocalStorage storage = LocalStorageShare();
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    UserDioClientModel user = UserDioClientModel();

    storage.get('userDio').then((value) {
      if (value != null) {
        user = UserDioClientModel.fromJson(jsonDecode(value[0])['user']);
      }
    });

    if (user.id != "" || user.id != null) {
      return true;
    } else {
      Modular.to.navigate('/auth/');
      return false;
    }
  }
}
