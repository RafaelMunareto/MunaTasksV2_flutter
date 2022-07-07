import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/model/notifications_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';

class DashboardService extends Disposable implements IDashboardService {
  final IDashboardRepository dashboardRepository;

  DashboardService({required this.dashboardRepository});

  @override
  void dispose() {}

  @override
  getDio(String id, int fase) {
    return dashboardRepository.getDio(id, fase);
  }

  @override
  getDioIndividual(String id) {
    return dashboardRepository.getDioIndividual(id);
  }

  @override
  getFilterUser(String id) {
    return dashboardRepository.getFilterUser(id);
  }

  @override
  getDioTotal(String id) {
    return dashboardRepository.getDioTotal(id);
  }

  @override
  deleteDio(TarefaDioModel model) {
    return dashboardRepository.deleteDio(model);
  }

  @override
  Future<dynamic> saveDio(TarefaDioModel model) {
    return dashboardRepository.saveDio(model);
  }

  @override
  updateDio(TarefaDioModel model) {
    return dashboardRepository.updateDio(model);
  }

  @override
  deleteNotifications(String id) {
    return dashboardRepository.deleteNotifications(id);
  }

  @override
  Future<List<NotificationsDioModel>> getNotifications(String id) {
    return dashboardRepository.getNotifications(id);
  }

  @override
  Future emailDio(String id, String tipo) {
    return dashboardRepository.emailDio(id, tipo);
  }

  @override
  Future<List<PerfilDioModel>> getPerfis() {
    return dashboardRepository.getPerfis();
  }

  @override
  Future<SettingsUserModel> getSettingsUser(String id) {
    return dashboardRepository.getSettingsUser(id);
  }

  @override
  Future<SettingsModel> getSettings() {
    return dashboardRepository.getSettings();
  }

  @override
  Future<List<EtiquetaDioModel>> getEtiquetas() {
    return dashboardRepository.getEtiquetas();
  }

  @override
  Future<PerfilDioModel> getPerfil(String id) {
    return dashboardRepository.getPerfil(id);
  }
}
