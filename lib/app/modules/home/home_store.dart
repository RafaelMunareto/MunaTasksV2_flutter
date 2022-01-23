import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IDashboardService dashboardService;
  final ILocalStorage storage = Modular.get();
  final AuthController auth = Modular.get();
  final FirebaseFirestore firestore = Modular.get();
  final ClientStore client = Modular.get();

  HomeStoreBase({required this.dashboardService}) {
    perfilUser();
    getList();
    buscaTheme();
    getEtiquetas();
    getOrder();
    getUsers();
    getRetard();
    getPrioridade();
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
  tratamentoBase(ObservableStream<List<TarefaModel>>? dashboardList) async {
    client.cleanUsersBase();
    client.cleanSubtarefaModel();
    client.setLoading(true);
    dashboardList!.forEach((e) async {
      for (var element in e) {
        element.data =
            DateTime.fromMillisecondsSinceEpoch(element.data.seconds * 1000);

        await relacionamentoUsers(element);
        if (client.usersBase.length == element.users?.length) {
          element.users = [];
          element.users = client.usersBase;
          client.cleanUsersBase();
        }

        await relacionamentoEtiqueta(element)
            .then((value) => element.etiqueta = value);

        for (var subtarefa in element.subTarefa!) {
          subtarefa = SubtarefaModel.fromJson(subtarefa);
          await relacionamentoUserSubtarefa(subtarefa).then((value) {
            subtarefa.user = value;
            client.setSubtarefaModel(subtarefa);
          });
        }
        if (client.subtarefaModel.length == element.subTarefa.length) {
          element.subTarefa = [];
          element.subTarefa = client.subtarefaModel;
          client.cleanSubtarefaModel();
        }
        await client.setTarefa(element);
        badgets();
      }
    });
  }

  relacionamentoUsers(TarefaModel element) async {
    for (var user in element.users!) {
      await firestore.collection('usuarios').doc(user.id).get().then((doc) {
        client.setUsersBase(UserModel.fromDocument(doc));
      });
    }
  }

  Future relacionamentoEtiqueta(TarefaModel element) {
    return firestore
        .collection('etiqueta')
        .doc(element.etiqueta.id)
        .get()
        .then((value) => EtiquetaModel.fromDocument(value));
  }

  Future relacionamentoUserSubtarefa(element) {
    return firestore
        .collection('usuarios')
        .doc(element.user.id)
        .get()
        .then((doc) {
      var user = UserModel.fromDocument(doc);
      return user;
    });
  }

  @action
  perfilUser() {
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

  @action
  void save(TarefaModel model) {
    client.setLoading(true);
    dashboardService.save(model);
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
  void logout() {
    auth.logout();
  }

  @action
  changeFilterEtiquetaList() {
    client.setLoading(true);
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
    client.setLoading(true);
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
    client.setLoading(true);
    model.prioridade = client.prioridadeSelection;
    save(model);
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
