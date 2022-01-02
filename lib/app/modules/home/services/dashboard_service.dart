import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';

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
  delete(TarefaModel model) {
    return dashboardRepository.delete(model);
  }

  @override
  Future save(TarefaModel model) {
    return dashboardRepository.save(model);
  }
}
