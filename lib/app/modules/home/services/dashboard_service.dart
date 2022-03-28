import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/model/fase_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

class DashboardService extends Disposable implements IDashboardService {
  final IDashboardRepository dashboardRepository;

  DashboardService({required this.dashboardRepository});

  @override
  void dispose() {}

  @override
  Stream<List<EtiquetaModel>> getEtiquetas() {
    return dashboardRepository.getEtiquetas();
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
  Stream<List<SubtarefaInsertModel>> getSubtarefaInsert() {
    return dashboardRepository.getSubtarefaInsert();
  }

  @override
  Stream<List<FaseModel>> getFase() {
    return dashboardRepository.getFase();
  }

  @override
  getDio(String id, int fase) {
    return dashboardRepository.getDio(id, fase);
  }

  @override
  getDioIndividual(String id) {
    return dashboardRepository.getDioIndividual(id);
  }

  @override
  getDioTotal() {
    return dashboardRepository.getDioTotal();
  }

  @override
  deleteDio(TarefaDioModel model) {
    return dashboardRepository.deleteDio(model);
  }

  @override
  saveDio(TarefaDioModel model) {
    return dashboardRepository.saveDio(model);
  }

  @override
  updateDio(TarefaDioModel model) {
    return dashboardRepository.updateDio(model);
  }
}
