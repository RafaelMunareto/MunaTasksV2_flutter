import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_create_store.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_totais_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/user_menu_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

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
    getUsers();
    // getList();
    buscaTheme();
    getEtiquetas();
    getOrder();
    getRetard();
    getPrioridade();
    getSubtarefaInsert();
    getFase();
    getDio();
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

    dashboardService.getDio(
        client.userDio.user!.id, client.navigateBarSelection);
  }

  @action
  void getEtiquetas() {
    client.etiquetaList = dashboardService.getEtiquetas().asObservable();
  }

  @action
  void getOrder() {
    client.orderList = dashboardService.getOrder().asObservable();
  }

  @action
  void getDio() {
    client.setLoading(true);
    getUid();
    dashboardService
        .getDio(client.userDio.user!.id, client.navigateBarSelection)
        .then((value) {
      client.setTaskDio(value);
      client.taskDio
          .where((element) => element.fase == client.navigateBarSelection)
          .toList();

      List<int> badgets = [
        client.taskDio.where((element) => element.fase == 0).toList().length,
        client.taskDio.where((element) => element.fase == 1).toList().length,
        client.taskDio.where((element) => element.fase == 2).toList().length
      ];
      client.setBadgetNavigate(badgets);
      client.setLoading(false);
    });
  }

  @observable
  UserMenuModel user = UserMenuModel();

  @action
  getUid() {
    storage.get('user').then((value) {
      user.uid = value[0];
      user.name = value[1];
      user.imgUrl = value[2];
    });
    storage.get('userDio').then((value) {
      client.setUserDio(UserDioModel.fromJson(value[0]));
    });
  }

  @action
  void getUsers() {
    client.userList = dashboardService.getUsers().asObservable();
  }

  @action
  void getRetard() {
    client.retardList = dashboardService.getRetard().asObservable();
  }

  @action
  void getPrioridade() {
    client.prioridadeList = dashboardService.getPrioridade().asObservable();
  }

  @action
  void getFase() {
    clientCreate.faseList = dashboardService.getFase().asObservable();
  }

  @action
  void getSubtarefaInsert() {
    clientCreate.subtarefaInsertList =
        dashboardService.getSubtarefaInsert().asObservable();
  }

  @action
  save(TarefaModel model) async {
    if (model.reference == null) client.setTarefa(model);
  }

  @action
  void saveNewTarefa() {
    save(clientCreate.tarefaModelSave);
  }

  @action
  void deleteTasks(TarefaModel model) {
    dashboardService.delete(model);
    client.deleteTarefasBase(model);
  }

  @action
  void deleteDioTasks(TarefaDioModel model) {
    // dashboardService.delete(model);
    // client.deleteTarefasBase(model);
  }

  @action
  changeFilterEtiquetaList() {
    client.changeTarefa(client.tarefasBase);
    if (client.etiquetaSelection == 57585) {
      client.changeTarefa(client.tarefas
          .where((b) => b.fase == client.navigateBarSelection)
          .toList());
    } else if (client.etiquetaSelection == 58873) {
      setNavigateBarSelection(2);
      client.changeTarefa(
        client.tarefas
            .where((b) => b.fase == 2)
            .where((c) => c.data.isAfter(dataSemana(c.data)))
            .toList(),
      );
    } else {
      client.changeTarefa(client.tarefas
          .where((e) => e.etiqueta.icon == client.etiquetaSelection)
          .where((b) => b.fase == client.navigateBarSelection)
          .toList());
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
        client.changeTarefa(client.tarefas
            .where((t) => t.texto
                .toLowerCase()
                .contains(client.searchValue.toLowerCase()))
            .where((b) => b.fase == client.navigateBarSelection)
            .toList());
      });
    } else {
      client.changeTarefa(client.tarefasBase
          .where((b) => b.fase == client.navigateBarSelection)
          .toList());
    }
  }

  @action
  changeFilterUserList() async {
    await client.changeTarefa(client.tarefasBase
        .where((b) => b.fase == client.navigateBarSelection)
        .toList());

    if (client.userSelection?.name != 'TODOS') {
      client.changeTarefa(client.tarefas
          .where((t) {
            bool eSelecaodoUser = false;
            t.users?.forEach((element) {
              if (element.reference.id == client.userSelection?.reference?.id) {
                eSelecaodoUser = true;
              }
            });
            return eSelecaodoUser;
          })
          .where((b) => b.fase == client.navigateBarSelection)
          .toList());
    }
  }

  @action
  changePrioridadeList(TarefaModel model) {
    model.prioridade = client.prioridadeSelection;
    save(model);
  }

  @action
  changeSubtarefaAction(
      SubtarefaModel subtarefaModel, TarefaModel tarefaModel) {
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
  updateDate(TarefaModel model) {
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

  @action
  usersTarefasTotais() {
    var users = [];
    var etiquetas = [];
    var finaliza = 0;
    client.cleanTarefasTotais();
    TarefaTotaisModel tarefaTotaisModel = TarefaTotaisModel();

    client.tarefasBase.forEach((element) {
      finaliza++;
      element.users!.forEach((e) {
        if (users.where((b) => b.reference!.id == e.reference!.id).isEmpty) {
          tarefaTotaisModel.users = e;
          client.setTarefasTotais(tarefaTotaisModel);
          tarefaTotaisModel = TarefaTotaisModel();
        } else {
          if (client.tarefasTotais
              .where((c) => c.users!.reference!.id == e!.reference!.id)
              .isEmpty) {
            tarefaTotaisModel.users = e;
            tarefaTotaisModel.total = 0;
            client.setTarefasTotais(tarefaTotaisModel);
            tarefaTotaisModel = TarefaTotaisModel();
          }
        }
        users.add(e);
      });
    });

    client.tarefasTotais.forEach((e) {
      e.etiqueta = client.tarefasBase
          .where((t) {
            return t.users!
                .where((u) => u.reference.id == e.users!.reference!.id)
                .isNotEmpty;
          })
          .map((element) => element.etiqueta)
          .toList();

      if (e.etiqueta!.isNotEmpty) {
        e.total = e.etiqueta!.length;
      }
    });
    // client.userList!.forEach((element) {
    //   element.forEach((b) {
    //     if (client.tarefasTotais
    //         .where((c) => b.reference!.id == c.users!.reference!.id)
    //         .isEmpty) {
    //       tarefaTotaisModel.users = element.first;
    //       tarefaTotaisModel.total = 0;
    //       client.setTarefasTotais(tarefaTotaisModel);
    //       tarefaTotaisModel = TarefaTotaisModel();
    //     }
    //   });
    // });
  }
}
