import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';

class AuthGuard extends RouteGuard {
  final ILocalStorage storage = LocalStorageShare();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    var uid = '';

    await storage.get('user').then((value) {
      if (value != null) {
        uid = value[0];
      } else {
        uid = auth.currentUser!.uid;
      }
    });
    if (uid != "") {
      return true;
    } else {
      Modular.to.navigate('/auth/');
      return false;
    }
  }
}
