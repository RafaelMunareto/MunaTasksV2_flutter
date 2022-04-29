import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_create_store.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/fase_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/retard_dio_model.dart';
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
  final ClientStore client = Modular.get();
  final ClientCreateStore clientCreate = Modular.get();

  HomeStoreBase({required this.dashboardService}) {
    getList();
    buscaTheme();
  }

  void getList() async {
    await client.setLoading(true);
    await client.setLoadingTasks(true);
    await client.setLoadingTasksTotal(true);
    await getUid();
    await getPerfil();
    await settings();
    await badgets();
    await getEtiquetas();
    await getUser();
    await getDioTotal();
    await getDio();
    await getDioFase();
  }

  buscaTheme() {
    storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        client.theme = true;
      } else {
        client.theme = false;
      }
    });
  }

  setNavigateBarSelection(value) async {
    await client.setLoadingTasks(true);
    await client.setNavigateBarSelection(value);
    await client.setEtiquetaSelection(57585);
    await client.setOrderAscDesc(true);
    await client.setOrderSelection('DATA');
    await client.setColor('blue');
    await client.setIcon(0);
    getDioFase();
  }

  getEtiquetas() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('etiquetas');
    DioStruture().statusRequest(response);
    client.setEtiquetas((response.data as List).map((e) {
      return EtiquetaDioModel.fromJson(e);
    }).toList());
  }

  getDioFase() {
    dashboardService
        .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
        .then((value) {
      client.setTaskDio(value);
      client.setLoadingTasks(false);
    });
  }

  getDio() {
    dashboardService
        .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
        .then((value) {
      client.setTaskDio(value);
      client.setLoadingTasks(false);
    });
  }

  badgets() {
    dashboardService.getDioIndividual(client.perfilUserLogado.id).then((value) {
      List<int> badgets = [
        value.where((element) => element.fase == 0).toList().length,
        value.where((element) => element.fase == 1).toList().length,
        value.where((element) => element.fase == 2).toList().length
      ];

      client.setBadgetNavigate(badgets);
    });
  }

  getDioTotal() {
    dashboardService.getDioTotal().then((value) {
      client.setTarefasTotais(value);
      client.setLoadingTasksTotal(false);
    });
  }

  settings() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('settings');
    DioStruture().statusRequest(response);
    var resposta = SettingsModel.fromJson(response.data[0]);
    client.setFase((resposta.fase as List).map((e) {
      return FaseDioModel.fromJson(e);
    }).toList());
    client.setRetard((resposta.retard as List).map((e) {
      return RetardDioModel.fromJson(e);
    }).toList());
    client.setSettings(resposta);
  }

  getUid() {
    storage.get('userDio').then((value) {
      if (value != null) {
        client.setUserDio(
            UserDioClientModel.fromJson(jsonDecode(value[0])['user']));
      }
    });
  }

  getUser() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil');
    DioStruture().statusRequest(response);
    client.setPerfis((response.data as List).map((e) {
      return PerfilDioModel.fromJson(e);
    }).toList());
    client.setLoading(false);
  }

  getPerfil() async {
    Response response;
    if (client.userDio.id != null) {
      var dio = await DioStruture().dioAction();
      response = await dio.get('perfil/user/${client.userDio.id}');
      DioStruture().statusRequest(response);

      var resposta = PerfilDioModel.fromJson(response.data[0]);
      client.setPerfilUserlogado(resposta);
    }
  }

  save(TarefaDioModel model) async {
    model.id == null
        ? await dashboardService.saveDio(model)
        : await dashboardService.updateDio(model);
    badgets();
    getDioTotal();
    getDio();
  }

  Future saveNewTarefa() async {
    await dashboardService.saveDio(clientCreate.tarefaModelSave);
    badgets();
    getDioTotal();
    getDio();
  }

  Future updateNewTarefa() async {
    await dashboardService.updateDio(clientCreate.tarefaModelSave);
    badgets();
    getDioTotal();
    getDio();
  }

  void deleteTasks(TarefaDioModel model) {
    dashboardService.deleteDio(model);
    getDio();
  }

  void deleteDioTasks(TarefaDioModel model) async {
    await dashboardService.deleteDio(model);
    badgets();
    getDioTotal();
    getDio();
  }

  changeFilterEtiquetaList() {
    if (client.etiquetaSelection == 57585) {
      getDio();
      getDioFase();
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

  filterDate() {
    dashboardService
        .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
        .then((value) {
      client.setTaskDio(value
          .where((element) =>
              element.data.isAfter(client.dateInicial) &&
              element.data
                  .isBefore(client.dateFinal.add(const Duration(days: 1))))
          .toList());
    });
  }

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
      getDioFase();
    }
  }

  changeFilterUserList() async {
    if (client.userSelection?.name.name != 'TODOS') {
      dashboardService
          .getDio(client.userSelection!.id, client.navigateBarSelection)
          .then((value) {
        client.setTaskDio(value);
      });
    } else {
      getDioFase();
    }
  }

  changePrioridadeList(TarefaDioModel model) {
    model.prioridade = client.prioridadeSelection;
    save(model);
  }

  changeSubtarefaDioAction(
      SubtareDiofaModel subtarefaModel, TarefaDioModel tarefaModel) {
    for (var a in tarefaModel.subTarefa!) {
      if (a.title == subtarefaModel.title && a.texto == subtarefaModel.texto) {
        a.status = client.subtarefaAction;
      }
    }
    save(tarefaModel);
  }

  updateDate(TarefaDioModel model) {
    model.data = model.data.add(Duration(hours: client.retardSelection));
    save(model);
  }

  changeOrderList() {
    switch (client.orderSelection) {
      case 'ETIQUETA':
        client.taskDio.sort((a, b) => client.orderAscDesc
            ? a.etiqueta.etiqueta.compareTo(b.etiqueta.etiqueta)
            : b.etiqueta.etiqueta.compareTo(a.etiqueta.etiqueta));
        client.setTaskDio(client.taskDio);
        return;
      case 'ASSUNTO':
        client.taskDio.sort((a, b) => client.orderAscDesc
            ? a.texto.compareTo(b.texto)
            : b.texto.compareTo(a.texto));
        client.setTaskDio(client.taskDio);
        return;
      case 'DATA':
        client.taskDio.sort((a, b) => client.orderAscDesc
            ? a.data.compareTo(b.data)
            : b.data.compareTo(a.data));
        client.setTaskDio(client.taskDio);
        return;
      case 'PRIORIDADE':
        client.taskDio.sort((a, b) => client.orderAscDesc
            ? a.prioridade.compareTo(b.prioridade)
            : b.prioridade.compareTo(a.prioridade));
        client.setTaskDio(client.taskDio);
        return;
      default:
        client.setTaskDio(client.taskDio);
        return;
    }
  }
}
