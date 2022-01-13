import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
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

  @observable
  List<int> badgetNavigate = [0, 0, 0];

  @action
  setBadgetNavigate(value) => badgetNavigate = value;

  @observable
  String cardSelection = '';

  @observable
  List<TarefaModel> tarefas = [];

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
  setNavigateBarSelection(value) {
    navigateBarSelection = value;
    changeTarefa(
        tarefasBase.where((element) => element.fase == value).toList());
  }

  @action
  setSelection(value) => cardSelection = value;

  @observable
  Stream<List<dynamic>>? dashboardList;

  HomeStoreBase({required this.dashboardService}) {
    getList();
    buscaTheme();
  }

  @action
  void getList() {
    List<UserModel> users = [];
    UserModel? userSubtarefa;
    tarefasBase = [];
    dashboardList = dashboardService.get();

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
}
