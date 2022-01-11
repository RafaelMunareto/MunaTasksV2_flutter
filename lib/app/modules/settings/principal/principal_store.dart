import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'principal_store.g.dart';

class PrincipalStore = _PrincipalStoreBase with _$PrincipalStore;

abstract class _PrincipalStoreBase with Store {
  final ILocalStorage storage = Modular.get();

  _PrincipalStoreBase() {
    buscaTheme();
  }

  @observable
  bool isSwitched = false;

  @action
  buscaTheme() {
    storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        isSwitched = true;
      } else {
        isSwitched = false;
      }
    });
  }

  @action
  changeSwitch(value) {
    List<String> data = [];
    isSwitched = value;
    isSwitched ? data = ['dark'] : data = ['light'];
    storage.put('theme', data);
  }

  logoff() async {
    await storage.put('login-normal', []);
    await Modular.get<AuthController>().logout();
    Modular.to.navigate('/auth');
  }
}
