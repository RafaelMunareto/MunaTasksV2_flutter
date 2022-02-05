import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_create_store.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
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
    perfilUser();
    getUsers();
    getList();
    buscaTheme();
    getEtiquetas();
    getOrder();
    getRetard();
    getPrioridade();
    getSubtarefaInsert();
    getFase();
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
    client.navigateBarSelection = value;
    client.setEtiquetaSelection('TODOS');
    client.setOrderAscDesc(true);
    client.setOrderSelection('DATA');
    client.setColor('blue');
    client.setIcon(0);
    client.changeTarefa(
        client.tarefasBase.where((element) => element.fase == value).toList());
  }

  @action
  setSelection(value) => client.cardSelection = value;

  @action
  void getEtiquetas() {
    client.etiquetaList = dashboardService.getEtiquetas().asObservable();
  }

  @action
  void getOrder() {
    client.orderList = dashboardService.getOrder().asObservable();
  }

  @action
  void getList() {
    client.dashboardList = dashboardService.get().asObservable();
    tratamentoBase(client.dashboardList);
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
  tratamentoBase(ObservableStream<List<TarefaModel>>? dashboardList) async {
    client.cleanUsersBase();
    client.cleanSubtarefaModel();
    client.setLoading(true);
    await dashboardList!.forEach((e) async {
      if (e.isEmpty) {
        client.setLoading(false);
      }
      for (var element in e) {
        await relacionamentos(element);
        if (client.tarefasBase.length == e.length) {
          badgets();
        }
      }
    });
  }

  relacionamentos(element) async {
    element.data =
        DateTime.fromMillisecondsSinceEpoch(element.data.seconds * 1000);

    for (var i = 0; i < element.users!.length; i++) {
      await client.userList
          ?.map((event) =>
              event.where((w) => w.reference!.id == element.users![i].id))
          .first
          .then((value) async {
        await client.setUsersBase(value.first);
        if (element.users!.length == client.usersBase.length) {
          element.users = [];
          element.users = client.usersBase;
          client.cleanUsersBase();
          element.etiqueta = await relacionamentoEtiqueta(element);

          for (var subtarefa in element.subTarefa!) {
            subtarefa = SubtarefaModel.fromJson(subtarefa);
            subtarefa.user = await relacionamentoUserSubtarefa(subtarefa);
            client.setSubtarefaModel(subtarefa);
          }
          if (client.subtarefaModel.length == element.subTarefa.length) {
            element.subTarefa = [];
            element.subTarefa = client.subtarefaModel;
            client.cleanSubtarefaModel();
          }
          await client.setTarefa(element);
        }
      });
    }
  }

  @action
  badgets() {
    updateList();
    client.changeTarefa(client.tarefasBase
        .where((element) => element.fase == client.navigateBarSelection)
        .toList());
    List<int> badgets = [
      client.tarefasBase.where((element) => element.fase == 0).toList().length,
      client.tarefasBase.where((element) => element.fase == 1).toList().length,
      client.tarefasBase.where((element) => element.fase == 2).toList().length
    ];
    client.setBadgetNavigate(badgets);
    client.setLoading(false);
  }

  relacionamentoEtiqueta(TarefaModel element) async {
    return client.etiquetaList
        ?.map((event) =>
            event.where((w) => w.reference!.id == element.etiqueta.id))
        .first
        .then((value) {
      return value.first;
    });
  }

  relacionamentoUserSubtarefa(element) {
    return client.userList
        ?.map((event) => event.where((w) => w.reference!.id == element.user.id))
        .first
        .then((value) {
      return value.first;
    });
  }

  @action
  perfilUser() async {
    firestore
        .collection('perfil')
        .doc(auth.user!.uid)
        .get()
        .then((value) => PerfilModel.fromDocument(value))
        .then((value) => client.setPerfilUserlogado(value));
  }

  @action
  updateList() {
    if (client.perfilUserLogado.manager == false) {
      client.setImgUrl(client.perfilUserLogado.urlImage);
      client.setTarefasBase(
        client.tarefasBase
            .where((t) {
              bool eSelecaodoUser = false;
              t.users?.forEach((element) {
                if (element.reference.id == auth.user!.uid) {
                  eSelecaodoUser = true;
                }
              });
              return eSelecaodoUser;
            })
            .where((b) => b.fase == client.navigateBarSelection)
            .toList(),
      );
    }
  }

  @action
  void save(TarefaModel model) {
    client.setLoading(true);
    dashboardService.save(model);
    client.cleanTarefas();
    client.cleanTarefasBase();
  }

  @action
  void saveNewTarefa() {
    dashboardService.save(clientCreate.tarefaModelSave);
    client.cleanTarefas();
    client.cleanTarefasBase();
  }

  @action
  void deleteTasks(TarefaModel model) {
    client.setLoading(true);
    dashboardService.delete(model);
    client.cleanTarefas();
    client.cleanTarefasBase();
  }

  @action
  changeFilterEtiquetaList() {
    client.changeTarefa(client.tarefasBase);

    if (client.etiquetaSelection != 'TODOS') {
      client.changeTarefa(client.tarefas
          .where((e) => e.etiqueta.etiqueta == client.etiquetaSelection)
          .where((b) => b.fase == client.navigateBarSelection)
          .toList());
    } else {
      client.changeTarefa(client.tarefas
          .where((b) => b.fase == client.navigateBarSelection)
          .toList());
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
    client.setLoading(true);
    subtarefaModel.status = client.subtarefaAction;
    save(tarefaModel);
  }

  @action
  updateDate(TarefaModel model) {
    client.setLoading(true);
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
