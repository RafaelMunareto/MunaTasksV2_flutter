import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';

import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'tarefas_store.g.dart';

class TarefasStore = _TarefasStoreBase with _$TarefasStore;

abstract class _TarefasStoreBase with Store {
  final ILocalStorage storage = Modular.get();
  final ClientStore client = Modular.get();
  final IDashboardService dashboardService;

  _TarefasStoreBase({required this.dashboardService}) {
    usersAutoComplete();
  }

  usersAutoComplete() async {
    await dashboardService.getPerfis().then((value) async {
      client.setPerfis(value);
    });
  }
}
