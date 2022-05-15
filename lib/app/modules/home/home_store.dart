import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:munatasks2/app/app_widget.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_create_store.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefas_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/fase_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/retard_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
import 'package:munatasks2/app/shared/utils/notification_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  }

  void getList() async {
    await getVersion();
    await client.setLoading(true);
    await client.setLoadingTasks(true);
    await client.setLoadingTasksTotal(true);
    await getUid();
    await getPerfil();
    await settings();
    await badgets();
    await getEtiquetas();
    await getSettingsUser();
    await getUser();
    await getDioTotal();
    await getDio();
    await getDioFase();
    await getNotificationsBd();
  }

  buscaTheme(context) async {
    await storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        client.setTheme(true);
      } else {
        client.setTheme(false);
      }
      client.setThemeLoading(true);
    });

    AppWidget.of(context)
        ?.changeTheme(client.theme ? ThemeMode.dark : ThemeMode.light);
  }

  getVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      client.setVersion(packageInfo.version);
    });
  }

  getNotificationsBd() async {
    if (client.settingsUser.mobile) {
      await dashboardService
          .getNotifications(client.perfilUserLogado.id)
          .then((e) {
            client.setNotifications(e);
          })
          .then((value) => client.setLoadingNotifications(true))
          .whenComplete(() =>
              dashboardService.deleteNotifications(client.perfilUserLogado.id));

      if (client.notifications.isNotEmpty) {
        retornaNotifications(client.notifications);
      }
    }
  }

  getSettingsUser() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response =
        await dio.get('perfil/settingsUser/${client.perfilUserLogado.id}');
    DioStruture().statusRequest(response);
    if (response.data.isEmpty) {
      SettingsUserModel settings =
          SettingsUserModel(user: client.perfilUserLogado.id);
      saveSettings(settings);
    } else {
      client.setSettingsUser(SettingsUserModel.fromJson(response.data[0]));
    }
  }

  Future saveSettings(SettingsUserModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.post('perfil/settingsUser', data: model.toJson(model));
    DioStruture().statusRequest(response);
    return client.setSettingsUser(SettingsUserModel.fromJson(response.data));
  }

  retornaNotifications(e) async {
    var texto = e.length > 1 ? 'novas tarefas' : 'nova tarefa';
    var textos = '';
    for (var i = 0; i < e.length; i++) {
      var pontos = i < (e.length - 1) ? ', ' : '.';
      textos = textos + e[i].texto.toString() + pontos;

      if (i == (e.length - 1)) {
        NotificationService().showNotification(
            2, "Você possuí ${e.length} $texto", "  $textos", 10);
      }
    }
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

  getPass() async {
    await getDio();
    await badgets();
    getDioTotal();
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
      client.setTaskDioSearch(value);
    }).whenComplete(() => client.setLoadingTasks(false));
  }

  getDio() {
    dashboardService
        .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
        .then((value) {
      client.setTaskDioSearch(value);
      client.setTaskDio(value);
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
      value.sort((a, b) => b.qtd.compareTo(a.qtd));
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

  getUid() async {
    storage.get('userDio').then((value) {
      if (value != null) {
        client.setUserDio(UserDioClientModel.fromJson(jsonDecode(value[0])));
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
      try {
        response = await dio.get('perfil/user/${client.userDio.id}');
        DioStruture().statusRequest(response);

        if (response.data != null) {
          var resposta = PerfilDioModel.fromJson(response.data[0]);
          client.setPerfilUserlogado(resposta);
        }
      } catch (e) {
        await SessionManager().remove('token');
        await storage.put('token', []);
        await storage.put('userDio', []);
        await storage.put('login-normal', []);
        Modular.to.navigate('/auth/');
      }
    }
  }

  save(TarefaDioModel model) async {
    model.id == null
        ? await dashboardService.saveDio(model)
        : await dashboardService.updateDio(model).then((value) {
            if (client.settingsUser.emailFinal && model.fase == 2) {
              dashboardService.emailDio(value.data['id'], '1');
            }
          });
    getPass();
  }

  Future saveNewTarefa() async {
    await dashboardService.saveDio(clientCreate.tarefaModelSave).then((value) {
      if (client.settingsUser.emailInicial) {
        dashboardService.emailDio(value.data['id'], '0');
      }
    });
    getPass();
  }

  Future updateNewTarefa() async {
    await dashboardService.updateDio(clientCreate.tarefaModelSave);
    getPass();
  }

  void deleteDioTasks(TarefaDioModel model) async {
    await dashboardService.deleteDio(model);
    getPass();
  }

  changeFilterEtiquetaList() {
    if (client.etiquetaSelection == 57585) {
      getDio();
      getDioFase();
    } else {
      dashboardService
          .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
          .then((value) {
        client.setTaskDioSearch(value
            .where((e) => e.etiqueta.icon == client.etiquetaSelection)
            .toList());
      });
    }
  }

  filterDate() {
    dashboardService
        .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
        .then((value) {
      client.setTaskDioSearch(value
          .where((element) =>
              element.data.isAfter(
                  client.dateInicial.subtract(const Duration(days: 1))) &&
              element.data
                  .isBefore(client.dateFinal.add(const Duration(days: 1))))
          .toList());
    });
  }

  changeFilterSearchList() {
    if (client.searchValue != '') {
      Timer(const Duration(milliseconds: 600), () {
        client.setTaskDioSearch(client.taskDio
            .where((t) => t.texto
                .toLowerCase()
                .contains(client.searchValue.toLowerCase()))
            .toList());
      });
    } else {
      client.setTaskDioSearch(client.taskDio);
    }
  }

  changeFilterUserList() async {
    if (client.userSelection?.name.name != 'TODOS') {
      dashboardService.getFilterUser(client.userSelection!.id).then((value) {
        client.setTaskDioSearch(value);
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
      SubtarefasDioModel subtarefaModel, TarefaDioModel tarefaModel) {
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
        client.setTaskDioSearch(client.taskDio);
        return;
      case 'ASSUNTO':
        client.taskDio.sort((a, b) => client.orderAscDesc
            ? a.texto.compareTo(b.texto)
            : b.texto.compareTo(a.texto));
        client.setTaskDioSearch(client.taskDio);
        return;
      case 'DATA':
        client.taskDio.sort((a, b) => client.orderAscDesc
            ? a.data.compareTo(b.data)
            : b.data.compareTo(a.data));
        client.setTaskDioSearch(client.taskDio);
        return;
      case 'PRIORIDADE':
        client.taskDio.sort((a, b) => client.orderAscDesc
            ? a.prioridade.compareTo(b.prioridade)
            : b.prioridade.compareTo(a.prioridade));
        client.setTaskDioSearch(client.taskDio);
        return;
      default:
        client.setTaskDioSearch(client.taskDio);
        return;
    }
  }
}
