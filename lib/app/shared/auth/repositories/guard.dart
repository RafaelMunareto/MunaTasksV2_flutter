import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';

class AuthGuard extends RouteGuard {
  final ILocalStorage storage = LocalStorageShare();
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    var uid = '';
    await storage.get('user').then((value) {
      uid = value[0];
    });
    if (uid.isNotEmpty) {
      return true;
    } else {
      Modular.to.navigate('/auth');
      return false;
    }
  }
}
