import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IDashboardService dashboardService;
  final AuthController auth = Modular.get();
  final FirebaseFirestore firestore = Modular.get();

  @observable
  String cardSelection = '';

  @observable
  List<TarefaModel> tarefas = [];

  @observable
  bool loading = true;

  @action
  setLoading(value) => loading = value;

  @action
  setTarefa(value) => tarefas.add(value);

  @observable
  int navigateBarSelection = 0;

  @action
  setNavigateBarSelection(value) => navigateBarSelection = value;

  @action
  setSelection(value) => cardSelection = value;

  @observable
  Stream<List<TarefaModel?>>? dashboardList;

  HomeStoreBase({required this.dashboardService}) {
    getList();
  }

  @action
  void getList() {
    List<UserModel> users = [];
    UserModel? userSubtarefa;
    dashboardList = dashboardService.get();
    dashboardList!.forEach((e) {
      e.forEach((element) {
        for (var subtarefa in element!.subTarefa!) {
          var str = subtarefa.user.split('/');
          var id = str[1];
          firestore.collection('usuarios').doc(id).get().then((doc) {
            // ignore: prefer_conditional_assignment
            if (userSubtarefa == null) {
              userSubtarefa = UserModel.fromDocument(doc);
            }
          }).whenComplete(() {
            subtarefa.user = userSubtarefa;
            for (var linha in element.users!) {
              var str = linha.split('/');
              var id = str[1];
              firestore.collection('usuarios').doc(id).get().then((doc) {
                if (users.isEmpty) {
                  users.add(UserModel.fromDocument(doc));
                }
              }).whenComplete(() {
                if (element.users!.length == users.length) {
                  element.users = users;
                  setTarefa(element);
                  if (tarefas.isNotEmpty) {
                    setLoading(false);
                  }
                }
              });
            }
          });
        }
      });
    });
  }

  @action
  void save(TarefaModel model) {
    dashboardService.save(model);
  }

  @action
  void delete(TarefaModel model) {
    dashboardService.delete(model);
  }

  @action
  void logout() {
    auth.logout();
  }
}
