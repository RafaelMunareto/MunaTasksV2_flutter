import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_total_model.dart';

abstract class IDashboardRepository {
  Future<List<TarefaDioModel>> getDio(String id, int fase);
  Future<List<TarefaDioModel>> getDioIndividual(String id);
  Future<List<TarefaDioTotalModel>> getDioTotal();
  saveDio(TarefaDioModel model);
  updateDio(TarefaDioModel model);
  deleteDio(TarefaDioModel model);
}
