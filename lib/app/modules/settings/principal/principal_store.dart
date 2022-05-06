import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/retard_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

import '../etiquetas/shared/models/settings_user_model.dart';

part 'principal_store.g.dart';

class PrincipalStore = _PrincipalStoreBase with _$PrincipalStore;

abstract class _PrincipalStoreBase with Store {
  final ILocalStorage storage = Modular.get();
  final IEtiquetaService etiquetaService;

  _PrincipalStoreBase({required this.etiquetaService}) {
    getList();
    buscaTheme();
    settingsAction();
  }

  @observable
  UserDioClientModel user = UserDioClientModel();

  @action
  setUser(value) => user = value;

  @observable
  PerfilDioModel perfil = PerfilDioModel();

  @action
  setPerfil(value) => perfil = value;

  getList() async {
    await getUid();
    await getBydDioId();
    await getSettingsUser();
  }

  getUid() {
    storage.get('userDio').then((value) {
      setUser(UserDioClientModel.fromJson(jsonDecode(value[0])));
    });
  }

  getBydDioId() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/user/${user.id}');
    setPerfil(PerfilDioModel.fromJson(response.data[0]));
  }

  getSettingsUser() {
    setLoadingSettingsUser(true);
    etiquetaService.getSettingsUser(perfil.id).then((value) {
      setSettingsUser(value);
    }).whenComplete(() => setLoadingSettingsUser(false));
  }

  updateSettingsUser(SettingsUserModel settings) {
    etiquetaService.updateSettingsUser(settings);
  }

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
        return 'Deve ser um número.';
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
        return 'Descrição deve ser > 3 caracteres.';
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
    await storage.delete('login-normal');
    await storage.delete('user');
    await storage.delete('token');
    await SessionManager().remove('token');
    await Modular.get<AuthController>().logout();
  }

  settingsAction() {
    etiquetaService.getSettings().then((value) {
      value.retard = value.retard!.map((e) {
        return RetardDioModel.fromJson(e);
      }).toList();
      setEscolha(value.order);
      setSettings(value);
    }).then((value) => setfinalize(false));
  }

  delete(value) {
    if (label == 'Tempo') {
      escolha.removeWhere((element) => element.tempoName == value.tempoName);
    } else {
      escolha.removeWhere((element) => element == value);
    }
    changeSettings();
  }

  edit(value, valueOld) {
    if (label == 'Order') {
      settings.order = escolha.map((e) {
        return e == valueOld ? valueEscolha : e;
      }).toList();
      setEscolha(settings.order);
    } else if (label == 'Color') {
      settings.color = escolha.map((e) {
        return e == valueOld ? valueEscolha : e;
      }).toList();
      setEscolha(settings.color);
    } else if (label == 'Subtarefa') {
      settings.subtarefaInsert = escolha.map((e) {
        return e == valueOld ? valueEscolha : e;
      }).toList();
      setEscolha(settings.subtarefaInsert);
    } else if (label == 'Prioridade') {
      settings.prioridade = escolha.map((e) {
        return e == valueOld ? valueEscolha : e;
      }).toList();
      setEscolha(settings.prioridade);
    } else if (label == 'Tempo') {
      settings.retard = escolha.map((e) {
        if (e.id == valueOld.id) {
          return RetardDioModel(
                  tempoName: valueEscolha.toString(),
                  tempoValue: int.parse(valueEscolha.split(' ')[0]) * 24)
              .toString();
        }
        return e;
      }).toList();
      setEscolha(settings.retard);
    }
    etiquetaService.updateSettings(settings);
  }

  novo(valueOld, value) {
    if (label == 'Prioridade') {
      value = int.parse(valueEscolha);
    }
    if (label == 'Tempo') {
      var tempoValue = int.parse(valueEscolha.split(' ')[0]) * 24;
      RetardDioModel data = RetardDioModel(
        tempoName: value,
        tempoValue: tempoValue,
      );
      escolha.add(data);
    } else {
      escolha.add(value);
    }
    changeSettings();
  }

  changeSettings() {
    if (label == 'Order') {
      settings.order = escolha;
      setEscolha(settings.order);
    } else if (label == 'Color') {
      settings.color = escolha;
      setEscolha(settings.color);
    } else if (label == 'Subtarefa') {
      settings.subtarefaInsert = escolha;
      setEscolha(settings.subtarefaInsert);
    } else if (label == 'Prioridade') {
      settings.prioridade = escolha;
      setEscolha(settings.prioridade);
    } else if (label == 'Tempo') {
      settings.retard = escolha;
      setEscolha(settings.retard);
    }
    etiquetaService.updateSettings(settings);
    etiquetaService.getSettings().then((value) {
      value.retard = value.retard!.map((e) {
        return RetardDioModel.fromJson(e);
      }).toList();
      setEscolha(escolha);
      setSettings(value);
    }).then((value) => setfinalize(false));
  }
}
