import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_create_store.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
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
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IDashboardService dashboardService;
  final ILocalStorage storage = Modular.get();
  final AuthController auth = Modular.get();
  final ClientStore client = Modular.get();
  final ClientCreateStore clientCreate = Modular.get();
  IO.Socket? socket;

  HomeStoreBase({required this.dashboardService}) {
    getList();
  }

  void getList() async {
    await client.setLoading(true);
    await connectToServer();
    await getVersion();
    await checkUpdateWindows();
    await getPerfis();
    await settings();
    await getUid();
    await getPerfil();
    await getNotificationsBd();
    await getEtiquetas();
    await getSettingsUser();
    await getDio();
    await getDioTotal();
    await badgets();
    await client.setLoading(false);
  }

  connectToServer() {
    socket = IO.io('http://api.munatask.com:3030', <String, dynamic>{
      'transports': ['websocket']
    });
    socket!.onConnect((_) {
      debugPrint('connect');
    });
    socket!.on('new_task', (data) => getNotificationsBd());
    socket!.on('updateList', (data) {
      getDio();
      badgets();
      getDioTotal();
    });
    socket!.onDisconnect((_) {
      debugPrint('disconnect');
    });
  }

  getVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      client.setVersion(packageInfo.version);
    });
  }

  checkUpdateWindows() {
    if (client.versionBd != client.version) {
      client.setCheckUpdateDesktop(true);
    }
  }

  getPerfis() async {
    dashboardService.getPerfis().then((value) {
      client.setPerfis(value);
    }).catchError((erro) {
      debugPrint(erro);
    });
  }

  settings() async {
    dashboardService.getSettings().then((value) {
      client.setVersionBd(value.version![0]);
      client.setFase((value.fase as List).map((e) {
        return FaseDioModel.fromJson(e);
      }).toList());
      client.setRetard((value.retard as List).map((e) {
        return RetardDioModel.fromJson(e);
      }).toList());
      client.setSettings(value);
    }).catchError((erro) {
      debugPrint(erro);
    });
  }

  getUid() async {
    storage.get('userDio').then((value) {
      if (value != null) {
        client.setUserDio(UserDioClientModel.fromJson(jsonDecode(value[0])));
      }
    });
  }

  getPerfil() async {
    dashboardService.getSettingsUser(client.userDio.id).then((value) {
      client.setPerfilUserlogado(value);
    }).catchError((erro) {
      debugPrint(erro);
    });
  }

  getNotificationsBd() async {
    if (client.settingsUser.mobile) {
      await dashboardService
          .getNotifications(client.perfilUserLogado.id)
          .then((e) {
        client.setNotifications(e);
      }).catchError((erro) {
        debugPrint(erro);
      }).whenComplete(() =>
              dashboardService.deleteNotifications(client.perfilUserLogado.id));
      if (client.notifications.isNotEmpty) {
        retornaNotifications(client.notifications);
      }
    }
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

  getEtiquetas() async {
    dashboardService.getSettingsUser(client.perfilUserLogado.id).then((value) {
      client.setEtiquetas(value);
    }).catchError((erro) {
      debugPrint(erro);
    });
  }

  getSettingsUser() async {
    dashboardService.getSettingsUser(client.perfilUserLogado.id).then((value) {
      client.setSettingsUser(value);
    }).catchError((erro) {
      debugPrint(erro);
    });
  }

  getDio() {
    dashboardService
        .getDio(client.perfilUserLogado.id, client.navigateBarSelection)
        .then((value) {
      client.setTaskDioSearch(value);
      client.setTaskDio(value);
      client.setCloseSearch(false);
    }).catchError((erro) {
      debugPrint(erro);
    });
  }

  getDioTotal() {
    dashboardService.getDioTotal().then((value) {
      value.sort((a, b) => b.qtd.compareTo(a.qtd));
      client.setTarefasTotais(value);
    }).catchError((erro) {
      debugPrint(erro);
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

  getPass() async {
    await client.setUserSelection(PerfilDioModel(
        name: UserDioClientModel(
            name: "TODOS", email: "todos@todos.com.br", password: ""),
        nameTime: "",
        idStaff: [],
        manager: true,
        urlImage: DioStruture().baseUrlMunatasks + 'files/todos.png'));
    await client.setImgUrl(DioStruture().baseUrlMunatasks + 'files/todos.png');
    await client.setLoadingRefresh(true);
    await getDio();
    await badgets();
    await getDioTotal();
  }

  save(TarefaDioModel model) async {
    if (model.id == null) {
      await dashboardService.saveDio(model);
      client.taskDioSearch.add(clientCreate.tarefaModelSave);
      client.setTaskDioSearch(client.taskDioSearch);
    } else {
      await dashboardService.updateDio(model).then((value) {
        if (client.settingsUser.emailFinal && model.fase == 2) {
          dashboardService.emailDio(value.data['id'], '1');
        }
      });
      client.taskDioSearch = client.taskDioSearch.map((e) {
        if (e.id == model.id) {
          return model;
        } else {
          return e;
        }
      }).toList();
      client.setTaskDio(client.taskDioSearch);
    }
    getDio();
    badgets();
    getDioTotal();
    Timer(const Duration(minutes: 2), () => socket!.emit('updateList', true));
  }

  saveNewTarefa() async {
    await dashboardService.saveDio(clientCreate.tarefaModelSave).then((value) {
      if (client.settingsUser.emailInicial) {
        dashboardService.emailDio(value.data['id'], '0');
      }
    });
    client.taskDioSearch.add(clientCreate.tarefaModelSave);
    client.setTaskDioSearch(client.taskDioSearch);
    getDio();
    badgets();
    getDioTotal();
    Timer(const Duration(minutes: 2), () => socket!.emit('newTaskFront', true));
  }

  updateNewTarefa() async {
    await dashboardService.updateDio(clientCreate.tarefaModelSave);
    client.taskDioSearch.map((e) {
      if (e.id == clientCreate.tarefaModelSave.id) {
        return clientCreate.tarefaModelSave as TarefaDioModel;
      } else {
        return e;
      }
    }).toList();
    getDio();
    badgets();
    getDioTotal();
    Timer(const Duration(minutes: 2), () => socket!.emit('updateList', true));
  }

  deleteDioTasks(TarefaDioModel model) async {
    await dashboardService.deleteDio(model);
    client.taskDioSearch.removeWhere((element) => element.id == model.id);
    client.setTaskDioSearch(client.taskDioSearch);
    getDio();
    badgets();
    getDioTotal();
    Timer(const Duration(minutes: 2), () => socket!.emit('updateList', true));
  }

  changeFilterEtiquetaList() {
    if (client.etiquetaSelection == 57585) {
      getDio();
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
    if (client.userSelection == null) {
      getDio();
    } else {
      if (client.userSelection?.name.name != 'TODOS') {
        dashboardService.getFilterUser(client.userSelection!.id).then((value) {
          client.setTaskDioSearch(value
              .where((element) => element.fase == client.navigateBarSelection)
              .toList());
        });
      } else {
        getDio();
      }
    }
  }

  changeOrderList() {
    switch (client.orderSelection) {
      case 'ETIQUETA':
        client.taskDioSearch.sort((a, b) => client.orderAscDesc
            ? a.etiqueta.etiqueta
                .toLowerCase()
                .compareTo(b.etiqueta.etiqueta.toLowerCase())
            : b.etiqueta.etiqueta
                .toLowerCase()
                .compareTo(a.etiqueta.etiqueta.toLowerCase()));
        client.setTaskDioSearch(client.taskDio);
        return;
      case 'ASSUNTO':
        client.taskDioSearch.sort((a, b) => client.orderAscDesc
            ? a.texto.compareTo(b.texto)
            : b.texto.compareTo(a.texto));
        client.setTaskDioSearch(client.taskDio);
        return;
      case 'DATA':
        client.taskDioSearch.sort((a, b) => client.orderAscDesc
            ? a.data.compareTo(b.data)
            : b.data.compareTo(a.data));
        client.setTaskDioSearch(client.taskDio);
        return;
      case 'PRIORIDADE':
        client.taskDioSearch.sort((a, b) => client.orderAscDesc
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
