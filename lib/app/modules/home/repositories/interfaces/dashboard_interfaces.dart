import 'package:munatasks2/app/modules/home/shared/model/notifications_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_total_model.dart';

abstract class IDashboardRepository {
  Future<List<TarefaDioModel>> getDio(String id, int fase);
  Future<List<NotificationsDioModel>> getNotifications(String id);
  Future<List<TarefaDioModel>> getDioIndividual(String id);
  Future<List<TarefaDioModel>> getFilterUser(String id);
  Future<List<TarefaDioTotalModel>> getDioTotal();
  Future<dynamic> saveDio(TarefaDioModel model);
  Future<dynamic> emailDio(String id, String tipo);
  updateDio(TarefaDioModel model);
  deleteDio(TarefaDioModel model);
  deleteNotifications(String id);
}
