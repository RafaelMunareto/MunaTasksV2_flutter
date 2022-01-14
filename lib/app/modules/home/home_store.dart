import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/model/order_model.dart';
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

  HomeStoreBase({required this.dashboardService}) {
    getList();
    buscaTheme();
    getEtiquetas();
  }

  @observable
  List<int> badgetNavigate = [0, 0, 0];

  @action
  setBadgetNavigate(value) => badgetNavigate = value;

  @observable
  String cardSelection = '';

  @observable
  List<TarefaModel> tarefas = [];

  @observable
  ObservableStream<List<EtiquetaModel>>? etiquetaList;

  @observable
  ObservableStream<List<OrderModel>>? orderList;

  @observable
  bool open = false;

  @observable
  String etiquetaSelection = 'TODOS';

  @observable
  String ordenamentoSelection = 'ORDENAMENTO';

  @action
  setOrdenamentoSelection(value) => ordenamentoSelection = value;

  @action
  setEtiquetaSelection(value) => etiquetaSelection = value;

  @action
  setOpen(value) => open = value;

  @observable
  List<TarefaModel> tarefasBase = [];

  @observable
  bool loading = true;

  @observable
  bool theme = false;

  @action
  buscaTheme() {
    storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        theme = true;
      } else {
        theme = false;
      }
    });
  }

  @action
  setLoading(value) => loading = value;

  @action
  setTarefa(value) => tarefasBase.add(value);

  @action
  cleanTarefasBase() => tarefasBase = [];

  @action
  changeTarefa(value) => tarefas = value;

  @action
  cleanTarefas() => tarefas = [];

  @observable
  int navigateBarSelection = 0;

  @action
  setColor(value) => color = value;

  @action
  setIcon(value) => icon = value;

  @observable
  String color = '';

  @observable
  int icon = 0;

  @observable
  bool closedListExpanded = false;

  @action
  setClosedListExpanded(value) => closedListExpanded = value;

  @action
  setNavigateBarSelection(value) {
    navigateBarSelection = value;
    setEtiquetaSelection('TODOS');
    setColor('blue');
    setIcon(0);
    changeTarefa(
        tarefasBase.where((element) => element.fase == value).toList());
  }

  @action
  setSelection(value) => cardSelection = value;

  @observable
  Stream<List<dynamic>>? dashboardList;

  @action
  void getEtiquetas() {
    etiquetaList = dashboardService.getEtiquetas().asObservable();
  }

  @action
  void getOrder() {
    orderList = dashboardService.getOrder().asObservable();
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
    tarefasBase = [];
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
                  setTarefa(element);
                  changeTarefa(tarefasBase
                      .where((element) => element.fase == navigateBarSelection)
                      .toList());
                  List<int> badgets = [
                    tarefasBase
                        .where((element) => element.fase == 0)
                        .toList()
                        .length,
                    tarefasBase
                        .where((element) => element.fase == 1)
                        .toList()
                        .length,
                    tarefasBase
                        .where((element) => element.fase == 2)
                        .toList()
                        .length
                  ];
                  setBadgetNavigate(badgets);
                }
              });
            }
          }).whenComplete(() {
            setLoading(false);
          });
        }
      }
    });
  }

  @action
  void save(TarefaModel model) {
    dashboardService.save(model);
    cleanTarefasBase();
  }

  @action
  void deleteTasks(TarefaModel model) {
    dashboardService.delete(model);
    cleanTarefasBase();
  }

  @action
  void logout() {
    auth.logout();
  }

  @action
  changeFilterEtiquetaList(String value) {
    changeTarefa(tarefasBase);

    if (etiquetaSelection != 'TODOS') {
      changeTarefa(tarefas
          .where((e) => e.etiqueta.etiqueta == etiquetaSelection)
          .where((b) => b.fase == navigateBarSelection)
          .toList());
    } else {
      changeTarefa(
          tarefas.where((b) => b.fase == navigateBarSelection).toList());
    }
  }
}
