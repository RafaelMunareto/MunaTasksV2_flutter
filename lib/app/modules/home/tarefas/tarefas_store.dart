import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/utils/functions_utils.dart';
import 'package:munatasks2/app/modules/home/tarefas/shared/controller/client_tarefas_store.dart';

import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'tarefas_store.g.dart';

class TarefasStore = _TarefasStoreBase with _$TarefasStore;

abstract class _TarefasStoreBase with Store {
  final ILocalStorage storage = Modular.get();
  final ClientStore client = Modular.get();
  final ClientTarefasStore clientStore = Modular.get();
  final IDashboardService dashboardService;

  _TarefasStoreBase({required this.dashboardService}) {
    usersAutoComplete();
    buscaTasksTotais();
  }

  usersAutoComplete() async {
    await dashboardService.getPerfis().then((value) async {
      client.setPerfis(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    });
  }

  buscaTasksTotais() async {
    await dashboardService.getTasksTodas().then((value) {
      clientStore.setTaskDio(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    }).whenComplete(() => calculosTempo());
  }

  buscaTarefa() async {
    await dashboardService.getFilterUser(clientStore.idSelection).then((value) {
      clientStore.setTaskDio(value);
    }).catchError((erro) {
      FunctionsUtils().showErrors(erro);
    }).whenComplete(() => calculosTempo());
  }

  calculosTempo() {
    var dados = clientStore.tasksDio;
  }
}
