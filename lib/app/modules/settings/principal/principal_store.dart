import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/retard_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/principal/controller/principal_client_store_store.dart';
import 'package:munatasks2/app/modules/settings/principal/services/interfaces/principal_service_interface.dart';
import 'package:munatasks2/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

import 'shared/model/settings_user_model.dart';

part 'principal_store.g.dart';

class PrincipalStore = _PrincipalStoreBase with _$PrincipalStore;

abstract class _PrincipalStoreBase with Store {
  final IPrincipalService principalService;
  PrincipalClientStoreStore client = PrincipalClientStoreStore();
  IAuthRepository auth = Modular.get();
  final ILocalStorage storage = Modular.get();

  _PrincipalStoreBase({required this.principalService}) {
    getList();
    client.buscaTheme();
    settingsAction();
  }

  getList() async {
    await client.getUid();
    await getBydDioId();
    await getSettingsUser();
  }

  getBydDioId() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/user/${client.user.id}');
    client.setPerfil(PerfilDioModel.fromJson(response.data[0]));
  }

  getSettingsUser() {
    client.setLoadingSettingsUser(true);
    principalService.getSettingsUser(client.perfil.id).then((value) {
      client.setSettingsUser(value);
    }).whenComplete(() => client.setLoadingSettingsUser(false));
  }

  updateSettingsUser(SettingsUserModel settings) {
    principalService.updateSettingsUser(settings);
  }

  logout() async {
    auth.getLogout();
  }

  settingsAction() {
    principalService.getSettings().then((value) {
      value.retard = value.retard!.map((e) {
        return RetardDioModel.fromJson(e);
      }).toList();
      client.setEscolha(value.order);
      client.setSettings(value);
    }).then((value) => client.setfinalize(false));
  }

  delete(value) {
    if (client.label == 'Tempo') {
      client.escolha
          .removeWhere((element) => element.tempoName == value.tempoName);
    } else {
      client.escolha.removeWhere((element) => element == value);
    }
    changeSettings();
  }

  edit(value, valueOld) {
    if (client.label == 'Order') {
      client.settings.order = client.escolha.map((e) {
        return e == valueOld ? client.valueEscolha : e;
      }).toList();
      client.setEscolha(client.settings.order);
    } else if (client.label == 'Color') {
      client.settings.color = client.escolha.map((e) {
        return e == valueOld ? client.valueEscolha : e;
      }).toList();
      client.setEscolha(client.settings.color);
    } else if (client.label == 'Subtarefa') {
      client.settings.subtarefaInsert = client.escolha.map((e) {
        return e == valueOld ? client.valueEscolha : e;
      }).toList();
      client.setEscolha(client.settings.subtarefaInsert);
    } else if (client.label == 'Prioridade') {
      client.settings.prioridade = client.escolha.map((e) {
        return e == valueOld ? client.valueEscolha : e;
      }).toList();
      client.setEscolha(client.settings.prioridade);
    } else if (client.label == 'Version') {
      client.settings.version = client.escolha.map((e) {
        return e == valueOld ? client.valueEscolha : e;
      }).toList();
      client.setEscolha(client.settings.version);
    } else if (client.label == 'Tempo') {
      client.settings.retard = client.escolha.map((e) {
        if (e.id == valueOld.id) {
          return RetardDioModel(
                  tempoName: client.valueEscolha.toString(),
                  tempoValue: int.parse(client.valueEscolha.split(' ')[0]) * 24)
              .toString();
        }
        return e;
      }).toList();
      client.setEscolha(client.settings.retard);
    }
    principalService.updateSettings(client.settings);
  }

  novo(valueOld, value) {
    if (client.label == 'Prioridade') {
      value = int.parse(client.valueEscolha);
    }
    if (client.label == 'Tempo') {
      var tempoValue = int.parse(client.valueEscolha.split(' ')[0]) * 24;
      RetardDioModel data = RetardDioModel(
        tempoName: value,
        tempoValue: tempoValue,
      );
      client.escolha.add(data);
    } else {
      client.escolha.add(value);
    }
    changeSettings();
  }

  changeSettings() {
    if (client.label == 'Order') {
      client.settings.order = client.escolha;
      client.setEscolha(client.settings.order);
    } else if (client.label == 'Color') {
      client.settings.color = client.escolha;
      client.setEscolha(client.settings.color);
    } else if (client.label == 'Subtarefa') {
      client.settings.subtarefaInsert = client.escolha;
      client.setEscolha(client.settings.subtarefaInsert);
    } else if (client.label == 'Prioridade') {
      client.settings.prioridade = client.escolha;
      client.setEscolha(client.settings.prioridade);
    } else if (client.label == 'Tempo') {
      client.settings.retard = client.escolha;
      client.setEscolha(client.settings.retard);
    } else if (client.label == 'Version') {
      client.settings.version = client.escolha;
      client.setEscolha(client.settings.version);
    }
    principalService.updateSettings(client.settings);
    principalService.getSettings().then((value) {
      value.retard = value.retard!.map((e) {
        return RetardDioModel.fromJson(e);
      }).toList();
      client.setEscolha(client.escolha);
      client.setSettings(value);
    }).then((value) => client.setfinalize(false));
  }
}
