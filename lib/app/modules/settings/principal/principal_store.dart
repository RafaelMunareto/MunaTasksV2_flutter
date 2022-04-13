import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'principal_store.g.dart';

class PrincipalStore = _PrincipalStoreBase with _$PrincipalStore;

abstract class _PrincipalStoreBase with Store {
  final ILocalStorage storage = Modular.get();
  final IEtiquetaService etiquetaService;

  _PrincipalStoreBase({required this.etiquetaService}) {
    buscaTheme();
    settingsAction();
  }

  @observable
  bool finalize = false;

  @action
  setfinalize(value) => finalize = value;

  @observable
  bool isSwitched = false;

  @action
  setIsSwitched(value) => isSwitched = value;

  @action
  buscaTheme() async {
    await storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        setIsSwitched(true);
      } else {
        setIsSwitched(false);
      }
    });
    setfinalize(true);
  }

  @observable
  SettingsModel settings = SettingsModel();

  @action
  setSettings(value) => settings = value;

  @action
  changeSwitch(value) {
    List<String> data = [];
    isSwitched = value;
    isSwitched ? data = ['dark'] : data = ['light'];
    storage.put('theme', data);
  }

  logoff() async {
    await storage.put('login-normal', []);
    await storage.put('user', []);
    await Modular.get<AuthController>().logout();
    Modular.to.navigate('/auth/');
  }

  settingsAction() {
    etiquetaService.getSettings().then((value) {
      setSettings(value);
    });
  }

  deleteColor(String color) {}

  novaCor() {}
}
