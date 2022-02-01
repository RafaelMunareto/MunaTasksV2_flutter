import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/model/fase_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/order_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/prioridade_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

class DashboardService extends Disposable implements IDashboardService {
  final IDashboardRepository dashboardRepository;

  DashboardService({required this.dashboardRepository});

  @override
  void dispose() {}

  @override
  Stream<List<TarefaModel>> get() {
    return dashboardRepository.get();
  }

  @override
  Stream<List<EtiquetaModel>> getEtiquetas() {
    return dashboardRepository.getEtiquetas();
  }

  @override
  Stream<List<OrderModel>> getOrder() {
    return dashboardRepository.getOrder();
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return dashboardRepository.getUsers();
  }

  @override
  Stream<List<RetardModel>> getRetard() {
    return dashboardRepository.getRetard();
  }

  @override
  Stream<List<PrioridadeModel>> getPrioridade() {
    return dashboardRepository.getPrioridade();
  }

  @override
  Stream<List<SubtarefaInsertModel>> getSubtarefaInsert() {
    return dashboardRepository.getSubtarefaInsert();
  }

  @override
  Stream<List<FaseModel>> getFase() {
    return dashboardRepository.getFase();
  }

  @override
  delete(TarefaModel model) {
    return dashboardRepository.delete(model);
  }

  @override
  save(TarefaModel model) {
    return dashboardRepository.save(model);
  }
}
