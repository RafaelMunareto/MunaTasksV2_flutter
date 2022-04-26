import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/retard_dio_model.dart';
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
    await storage.put('login-normal', []);
    await storage.put('user', []);
    await storage.put('token', []);
    await SessionManager().destroy();
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
      escolha.removeWhere((element) => element.toString() == value.toString());
    }
    changeSettings();
  }

  edit(value, valueOld) {
    if (label == 'Order') {
      settings.order = escolha.map((e) {
        return e == valueOld ? value : e;
      }).toList();
      setEscolha(settings.order);
    } else if (label == 'Color') {
      settings.color = escolha.map((e) {
        return e == valueOld ? value : e;
      }).toList();
      setEscolha(settings.color);
    } else if (label == 'Subtarefa') {
      settings.subtarefaInsert = escolha.map((e) {
        return e == valueOld ? value : e;
      }).toList();
      setEscolha(settings.subtarefaInsert);
    } else if (label == 'Prioridade') {
      settings.prioridade = escolha.map((e) {
        return e == valueOld ? value : e;
      }).toList();
      setEscolha(settings.prioridade);
    } else if (label == 'Tempo') {
      settings.retard = escolha.map((e) {
        if (e.id == valueOld.id) {
          return RetardDioModel(
              id: e.id,
              tempoName: value,
              tempoValue: int.parse(value.split(' ')[0]) * 24);
        }
        return e;
      }).toList();
      setEscolha(settings.retard);
    }
    etiquetaService.updateSettings(settings);
  }

  novo(valueOld, value) {
    if (label == 'Prioridade') {
      value = int.parse(value);
    }
    if (label == 'Tempo') {
      var tempoValue = int.parse(value.split(' ')[0]) * 24;
      RetardDioModel data = RetardDioModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
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
  }
}
