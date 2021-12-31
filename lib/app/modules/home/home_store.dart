import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IDashboardService dashboardService;
  final AuthController auth = Modular.get();

  @observable
  String cardSelection = '';

  @observable
  int navigateBarSelection = 0;

  @action
  setNavigateBarSelection(value) => navigateBarSelection = value;

  @action
  setSelection(value) => cardSelection = value;

  @observable
  ObservableStream<List<TarefaModel>>? dashboardList;

  HomeStoreBase({required this.dashboardService}) {
    getList();
  }

  @action
  void getList() {
    dashboardList = dashboardService.get().asObservable();
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
