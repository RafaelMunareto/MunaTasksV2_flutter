// ignore_for_file: library_prefixes
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_create_store.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/badgets_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/utils/functions_utils.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/fase_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/retard_dio_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
import 'package:munatasks2/app/shared/utils/notification_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    await settings();
    await getEtiquetas();
    await getPerfis();
    await getUid();
    await getPerfil();
    await getDioTotal();
    await getSettingsUser();
    await getDio();
    await client.setLoading(false);
    await getVersion();
    await checkUpdateWindows();
    await getNotificationsBd();
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
    await dashboardService.getPerfis().then((value) {
      client.setPerfis(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
  }

  getEtiquetas() async {
    await dashboardService.getEtiquetas().then((value) {
      client.setEtiquetas(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
  }

  settings() async {
    await dashboardService.getSettings().then((value) {
      client.setVersionBd(value.version![0]);
      client.setFase((value.fase as List).map((e) {
        return FaseDioModel.fromJson(e);
      }).toList());
      client.setRetard((value.retard as List).map((e) {
        return RetardDioModel.fromJson(e);
      }).toList());
      client.setSettings(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
  }

  getUid() async {
    await storage.get('userDio').then((value) {
      if (value != null) {
        client.setUserDio(UserDioClientModel.fromJson(jsonDecode(value[0])));
      }
    });
  }

  getPerfil() async {
    await dashboardService.getPerfil(client.userDio.id).then((value) {
      client.setPerfilUserlogado(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
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

  getSettingsUser() async {
    await dashboardService
        .getSettingsUser(client.perfilUserLogado.id)
        .then((value) {
      client.setSettingsUser(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
  }

  getDioTotal() async {
    await dashboardService
        .getDioTotal(client.perfilUserLogado.id)
        .then((value) {
      value.sort((a, b) => b.qtd.compareTo(a.qtd));
      client.setTarefasTotais(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
  }

  getDio() async {
    await await client.setLoadingItens(true);
    await dashboardService
        .getDioIndividual(client.perfilUserLogado.id)
        .then((value) {
      client.setTaskDioSearch(value);
      client.setTaskDio(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    }).whenComplete(() {
      badgets();
    });
  }

  badgets() {
    List<BadgetsModel> badgets = [
      BadgetsModel(
          name: 'Backlog',
          colors: Colors.amber,
          qtd: client.taskDioSearch
              .where((element) => element.fase == 0)
              .toList()
              .length,
          dados: client.taskDioSearch
              .where((element) => element.fase == 0)
              .toList()),
      BadgetsModel(
          name: 'Fazendo',
          colors: Colors.green,
          qtd: client.taskDioSearch
              .where((element) => element.fase == 1)
              .toList()
              .length,
          dados: client.taskDioSearch
              .where((element) => element.fase == 1)
              .toList()),
      BadgetsModel(
          name: 'Feito',
          colors: Colors.blue,
          qtd: client.taskDioSearch
              .where((element) => element.fase == 2)
              .toList()
              .length,
          dados: client.taskDioSearch
              .where((element) => element.fase == 2)
              .toList()),
      BadgetsModel(
          name: 'Prioritário',
          colors: Colors.red,
          qtd: client.taskDioSearch
              .where((element) => element.prioridade == 1)
              .toList()
              .length,
          dados: client.taskDioSearch
              .where((element) => element.prioridade == 1)
              .toList()),
    ];
    client.setBadgetNavigate(badgets);
    client.setLoadingItens(false);
  }

  getPass() async {
    await client.setTodos();
    await client.setImgUrl(DioStruture().baseUrlMunatasks + 'files/todos.png');
    getDio();
  }

  save(TarefaDioModel model) async {
    if (model.id == null) {
      await dashboardService.saveDio(model).catchError((erro) {
        debugPrint(erro);
      });
      client.taskDioSearch.add(clientCreate.tarefaModelSave);
      client.setTaskDioSearch(client.taskDioSearch);
    } else {
      await dashboardService.updateDio(model).then((value) async {
        if (client.settingsUser.emailFinal && model.fase == 2) {
          await dashboardService.emailDio(value.data['id'], '1');
        }
      }).catchError((erro) {
        debugPrint(erro);
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
    getPass();
    Timer(const Duration(minutes: 2), () => socket!.emit('updateList', true));
  }

  saveNewTarefa() async {
    await dashboardService
        .saveDio(clientCreate.tarefaModelSave)
        .then((value) async {
      if (client.settingsUser.emailInicial) {
        await dashboardService.emailDio(value.data['id'], '0');
      }
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
    client.taskDioSearch.add(clientCreate.tarefaModelSave);
    client.setTaskDioSearch(client.taskDioSearch);
    getPass();
    getDioTotal();
    Timer(const Duration(minutes: 2), () => socket!.emit('newTaskFront', true));
  }

  updateNewTarefa() async {
    await dashboardService
        .updateDio(clientCreate.tarefaModelSave)
        .catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
    client.taskDioSearch.map((e) {
      if (e.id == clientCreate.tarefaModelSave.id) {
        return clientCreate.tarefaModelSave as TarefaDioModel;
      } else {
        return e;
      }
    }).toList();
    getDio();
    getDioTotal();
    Timer(const Duration(minutes: 2), () => socket!.emit('updateList', true));
  }

  deleteDioTasks(TarefaDioModel model) async {
    await dashboardService.deleteDio(model).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
    client.taskDioSearch.removeWhere((element) => element.id == model.id);
    client.setTaskDioSearch(client.taskDioSearch);
    badgets();
    Timer(const Duration(minutes: 2), () => socket!.emit('updateList', true));
  }

  changeFilterEtiquetaList() async {
    await client.setLoadingItens(true);
    if (client.etiquetaSelection == 57585) {
      getDio();
    } else {
      await client.setLoadingItens(true);
      await client.setTaskDioSearch(client.taskDio
          .where((e) => e.etiqueta.icon == client.etiquetaSelection)
          .toList());
      badgets();
    }
  }

  filterDate() async {
    await client.setLoadingItens(true);
    dashboardService
        .getDioIndividual(client.perfilUserLogado.id)
        .then((value) async {
      await client.setTaskDioSearch(value
          .where((element) =>
              element.data.isAfter(
                  client.dateInicial.subtract(const Duration(days: 1))) &&
              element.data
                  .isBefore(client.dateFinal.add(const Duration(days: 1))))
          .toList());
      badgets();
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
  }

  changeFilterSearchList() async {
    await client.setLoadingItens(true);
    if (client.searchValue != '') {
      Timer(const Duration(milliseconds: 600), () async {
        await client.setTaskDioSearch(client.taskDio
            .where((t) => t.texto
                .toLowerCase()
                .contains(client.searchValue.toLowerCase()))
            .toList());
        badgets();
      });
    } else {
      client.setTaskDioSearch(client.taskDio);
      badgets();
    }
  }

  changeFilterUserList() async {
    await client.setLoadingItens(true);
    if (client.userSelection == null) {
      getDio();
    } else {
      if (client.userSelection?.name.name != 'TODOS') {
        await dashboardService
            .getFilterUser(client.userSelection!.id)
            .then((value) async {
          await client.setTaskDioSearch(value.toList());
          badgets();
        }).catchError((erro) {
          debugPrint(erro);
        }).whenComplete(() => badgets());
      } else {
        getDio();
      }
    }
  }

  changeOrderList() async {
    await client.setLoadingItens(true);
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
        badgets();
        return;
      case 'ASSUNTO':
        client.taskDioSearch.sort((a, b) => client.orderAscDesc
            ? a.texto.compareTo(b.texto)
            : b.texto.compareTo(a.texto));
        client.setTaskDioSearch(client.taskDio);
        badgets();
        return;
      case 'DATA':
        client.taskDioSearch.sort((a, b) => client.orderAscDesc
            ? a.data.compareTo(b.data)
            : b.data.compareTo(a.data));
        client.setTaskDioSearch(client.taskDio);
        badgets();
        return;
      case 'PRIORIDADE':
        client.taskDioSearch.sort((a, b) => client.orderAscDesc
            ? a.prioridade.compareTo(b.prioridade)
            : b.prioridade.compareTo(a.prioridade));
        client.setTaskDioSearch(client.taskDio);
        badgets();
        return;
      default:
        client.setTaskDioSearch(client.taskDio);
        badgets();
        return;
    }
  }
}
