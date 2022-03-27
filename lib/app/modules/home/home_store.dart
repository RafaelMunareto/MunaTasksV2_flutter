import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_create_store.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IDashboardService dashboardService;
  final ILocalStorage storage = Modular.get();
  final AuthController auth = Modular.get();
  final FirebaseFirestore firestore = Modular.get();
  final ClientStore client = Modular.get();
  final ClientCreateStore clientCreate = Modular.get();
  final FirebaseFunctions functions = Modular.get();

  HomeStoreBase({required this.dashboardService}) {
    getList();
    buscaTheme();
    getSubtarefaInsert();
  }

  void getList() async {
    await getUid();
    await getPerfil();
    await settings();
    await badgets();
    await getDioTotal();
    getEtiquetas();
    getUser();
    getDioFase();
  }

  @action
  buscaTheme() {
    storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        client.theme = true;
      } else {
        client.theme = false;
      }
    });
  }

  @action
  setNavigateBarSelection(value) {
    client.setNavigateBarSelection(value);
    client.setEtiquetaSelection(57585);
    client.setOrderAscDesc(true);
    client.setOrderSelection('DATA');
    client.setColor('blue');
    client.setIcon(0);
    getDio();
  }

  void getEtiquetas() async {
    Response response;
    response = await DioStruture().dioAction().get('etiquetas');
    DioStruture().statusRequest(response);
    client.setEtiquetas((response.data as List).map((e) {
      return EtiquetaDioModel.fromJson(e);
    }).toList());
  }

  @action
  void getDioFase() {
    client.setLoading(true);
    dashboardService
        .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
        .then((value) {
      client.setTaskDio(value);
    }).whenComplete(() => client.setLoading(false));
  }

  @action
  void getDio() {
    dashboardService
        .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
        .then((value) {
      client.setTaskDio(value);
    });
  }

  @action
  badgets() {
    dashboardService.getDioIndividual(client.userDio.id).then((value) {
      List<int> badgets = [
        value.where((element) => element.fase == 0).toList().length,
        value.where((element) => element.fase == 1).toList().length,
        value.where((element) => element.fase == 2).toList().length
      ];
      client.setBadgetNavigate(badgets);
    });
  }

  @action
  getDioTotal() async {
    await dashboardService.getDioTotal().then((value) {
      client.setTarefasTotais(value);
    });
  }

  settings() async {
    Response response;
    response = await DioStruture().dioAction().get('settings');
    DioStruture().statusRequest(response);
    var resposta = SettingsModel.fromJson(response.data[0]);
    client.setRetard((resposta.retard as List).map((e) {
      return RetardModel.fromJson(e);
    }).toList());
    client.setSettings(resposta);
  }

  getUid() {
    storage.get('userDio').then((value) {
      client.setUserDio(
          UserDioClientModel.fromJson(jsonDecode(value[0])['user']));
    });
  }

  getUser() async {
    Response response;
    response = await DioStruture().dioAction().get('perfil');
    DioStruture().statusRequest(response);
    client.setPerfis((response.data as List).map((e) {
      return PerfilDioModel.fromJson(e);
    }).toList());
  }

  @action
  getPerfil() async {
    Response response;
    response =
        await DioStruture().dioAction().get('perfil/user/${client.userDio.id}');
    DioStruture().statusRequest(response);
    var resposta = PerfilDioModel.fromJson(response.data[0]);
    client.setPerfilUserlogado(resposta);
  }

  @action
  void getSubtarefaInsert() {
    clientCreate.subtarefaInsertList =
        dashboardService.getSubtarefaInsert().asObservable();
  }

  @action
  save(TarefaDioModel model) async {
    model.id == null
        ? dashboardService.saveDio(model)
        : dashboardService.updateDio(model);
    getDio();
  }

  @action
  void deleteTasks(TarefaDioModel model) {
    dashboardService.deleteDio(model);
    getDio();
  }

  @action
  void deleteDioTasks(TarefaDioModel model) {
    // dashboardService.delete(model);
    // client.deleteTarefasBase(model);
  }

  @action
  changeFilterEtiquetaList() {
    if (client.etiquetaSelection == 57585) {
      getDio();
    } else if (client.etiquetaSelection == 58873) {
      setNavigateBarSelection(2);
      client.setTaskDio(
        client.taskDio
            .where((b) => b.fase == 2)
            .where((c) => c.data.isAfter(dataSemana(c.data)))
            .toList(),
      );
    } else {
      dashboardService
          .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
          .then((value) {
        client.setTaskDio(value
            .where((e) => e.etiqueta.icon == client.etiquetaSelection)
            .toList());
      });
    }
  }

  dataSemana(DateTime data) {
    DateTime now = DateTime.now();
    var diff = now.difference(data).inDays.toInt();

    if (diff < now.weekday.toInt()) {
      if (diff <= 0) {
        data = now;
      }
      return data.subtract(const Duration(days: 1));
    } else {
      data = data.add(const Duration(days: 1));
      return data;
    }
  }

  @action
  changeFilterSearchList() {
    if (client.searchValue != '') {
      Timer(const Duration(milliseconds: 600), () {
        client.setTaskDio(client.taskDio
            .where((t) => t.texto
                .toLowerCase()
                .contains(client.searchValue.toLowerCase()))
            .where((b) => b.fase == client.navigateBarSelection)
            .toList());
      });
    } else {
      getDio();
    }
  }

  @action
  changeFilterUserList() async {
    if (client.userSelection?.name.name != 'TODOS') {
      dashboardService
          .getDio(client.userSelection!.id, client.navigateBarSelection)
          .then((value) => client.setTaskDio(value));
    } else {
      getDio();
    }
  }

  @action
  changePrioridadeList(TarefaDioModel model) {
    model.prioridade = client.prioridadeSelection;
    save(model);
  }

  @action
  changeSubtarefaAction(
      SubtarefaModel subtarefaModel, TarefaDioModel tarefaModel) {
    subtarefaModel.status = client.subtarefaAction;
    save(tarefaModel);
  }

  @action
  changeSubtarefaDioAction(
      SubtareDiofaModel subtarefaModel, TarefaDioModel tarefaModel) {
    subtarefaModel.status = client.subtarefaAction;
    // save(tarefaModel);
  }

  @action
  updateDate(TarefaDioModel model) {
    model.data = model.data.add(Duration(hours: client.retardSelection));
    save(model);
  }

  @action
  changeOrderList() {
    switch (client.orderSelection) {
      case 'ETIQUETA':
        return client.tarefas.sort((a, b) => client.orderAscDesc
            ? a.etiqueta.etiqueta.compareTo(b.etiqueta.etiqueta)
            : b.etiqueta.etiqueta.compareTo(a.etiqueta.etiqueta));
      case 'ASSUNTO':
        return client.tarefas.sort((a, b) => client.orderAscDesc
            ? a.texto.compareTo(b.texto)
            : b.texto.compareTo(a.texto));
      case 'DATA':
        return client.tarefas.sort((a, b) => client.orderAscDesc
            ? a.data.compareTo(b.data)
            : b.data.compareTo(a.data));
      case 'PRIORIDADE':
        return client.tarefas.sort((a, b) => client.orderAscDesc
            ? a.prioridade.compareTo(b.prioridade)
            : b.prioridade.compareTo(a.prioridade));
      default:
        return client.tarefas;
    }
  }
}
