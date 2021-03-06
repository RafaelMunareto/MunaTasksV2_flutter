import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'principal_client_store_store.g.dart';

class PrincipalClientStoreStore = _PrincipalClientStoreStoreBase
    with _$PrincipalClientStoreStore;

abstract class _PrincipalClientStoreStoreBase with Store {
  final ILocalStorage storage = Modular.get();

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

  getUid() {
    storage.get('userDio').then((value) {
      setUser(UserDioClientModel.fromJson(jsonDecode(value[0])));
    });
  }

  @action
  changeSwitch(value) {
    value = value ? ['dark'] : ['light'];
    storage.put('theme', value);
  }

  @observable
  UserDioClientModel user = UserDioClientModel();

  @action
  setUser(value) => user = value;

  @observable
  PerfilDioModel perfil = PerfilDioModel();

  @action
  setPerfil(value) => perfil = value;

  @observable
  SettingsUserModel settingsUser = SettingsUserModel();

  @action
  setSettingsUser(value) => settingsUser = value;

  @observable
  bool loadingSettingsUser = false;

  @action
  setLoadingSettingsUser(value) => loadingSettingsUser = value;

  @observable
  dynamic valueEscolha = '';

  @action
  setValueEscolha(value) {
    valueEscolha = value;
  }

  @computed
  bool get isValidTarefa {
    return validTextoTarefa() == null;
  }

  String? validTextoTarefa() {
    if (label == 'Prioridade') {
      if (double.tryParse(valueEscolha) == null) {
        return 'Deve ser um n??mero.';
      }
      return null;
    } else if (label == 'Tempo') {
      if (valueEscolha.length > 0) {
        if (double.tryParse(valueEscolha.split(' ')[0]) == null) {
          return 'Formato em dias, 1 dia, 2 dias etc';
        }

        return null;
      }
      return null;
    } else {
      if (valueEscolha.length < 3) {
        return 'Descri????o deve ser > 3 caracteres.';
      }
      return null;
    }
  }

  @observable
  bool finalize = true;

  @action
  setfinalize(value) => finalize = value;

  @observable
  bool isSwitched = false;

  @observable
  List<dynamic> escolha = [];

  @observable
  String label = 'Order';

  @action
  setLabel(value) => label = value;

  @action
  setEscolha(value) {
    escolha = value;
    if (escolha.isNotEmpty) {
      if (label == 'Tempo') {
        escolha.sort((a, b) => a.tempoValue.compareTo(b.tempoValue));
      } else {
        escolha.sort((a, b) => a.compareTo(b));
      }
    }
  }

  @action
  setIsSwitched(value) => isSwitched = value;

  @observable
  SettingsModel settings = SettingsModel();

  @action
  setSettings(value) => settings = value;
}
