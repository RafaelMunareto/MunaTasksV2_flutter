import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
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
    getList();
    buscaTheme();
    getEtiquetas();
    getOrder();
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

  @observable
  Stream<List<dynamic>>? dashboardList;

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
    dashboardList = dashboardService.get();
    tratamentoBase(dashboardList);
  }

  @action
  tratamentoBase(Stream<List<dynamic>>? dashboardList) {
    UserModel? userSubtarefa;
    List<UserModel> users = [];
    client.tarefasBase = [];
    dashboardList!.forEach((e) {
      for (var element in e) {
        var etiqueta = element.etiqueta
            .toString()
            .replaceAll('/etiqueta', 'etiqueta')
            .split('/');
        var idEtiqueta = etiqueta[1].replaceAll(')', '');
        firestore.collection('etiqueta').doc(idEtiqueta).get().then(
            (value) => element.etiqueta = EtiquetaModel.fromDocument(value));

        for (var subtarefa in element!.subTarefa!) {
          var str = subtarefa.user
              .toString()
              .replaceAll('/usuarios', 'usuarios')
              .split('/');
          var id = str[1].replaceAll(')', '');

          firestore.collection('usuarios').doc(id).get().then((doc) {
            // ignore: prefer_conditional_assignment
            if (userSubtarefa == null) {
              userSubtarefa = UserModel.fromDocument(doc);
            }
          }).whenComplete(() {
            subtarefa.user = userSubtarefa;
            for (var linha in element.users!) {
              var str = linha
                  .toString()
                  .replaceAll('/usuarios', 'usuarios')
                  .split('/');
              var id = str[1].replaceAll(')', '');
              firestore.collection('usuarios').doc(id).get().then((doc) {
                if (users.isEmpty) {
                  users.add(UserModel.fromDocument(doc));
                }
              }).whenComplete(() {
                if (element.users!.length == users.length) {
                  element.users = users;
                  client.setTarefa(element);
                  client.changeTarefa(client.tarefasBase
                      .where((element) =>
                          element.fase == client.navigateBarSelection)
                      .toList());
                  List<int> badgets = [
                    client.tarefasBase
                        .where((element) => element.fase == 0)
                        .toList()
                        .length,
                    client.tarefasBase
                        .where((element) => element.fase == 1)
                        .toList()
                        .length,
                    client.tarefasBase
                        .where((element) => element.fase == 2)
                        .toList()
                        .length
                  ];
                  client.setBadgetNavigate(badgets);
                }
              });
            }
          }).whenComplete(() {
            client.setLoading(false);
          });
        }
      }
    });
  }

  @action
  void save(TarefaModel model) {
    dashboardService.save(model);
    client.cleanTarefasBase();
  }

  @action
  void deleteTasks(TarefaModel model) {
    dashboardService.delete(model);
    client.cleanTarefasBase();
  }

  @action
  void logout() {
    auth.logout();
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
