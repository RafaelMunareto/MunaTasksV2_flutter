import 'package:munatasks2/app/modules/home/shared/model/fase_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_total_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

abstract class IDashboardService {
  Stream<List<TarefaModel>> get();
  Stream<List<EtiquetaModel>> getEtiquetas();
  Future<List<TarefaDioModel>> getDio(String id, int fase);
  Future<List<TarefaDioModel>> getDioIndividual(String id);
  Future<List<TarefaDioTotalModel>> getDioTotal();
  Stream<List<UserModel>> getUsers();
  Stream<List<RetardModel>> getRetard();
  Stream<List<SubtarefaInsertModel>> getSubtarefaInsert();
  Stream<List<FaseModel>> getFase();
  save(TarefaModel model);
  saveDio(TarefaDioModel model);
  updateDio(TarefaDioModel model);
  deleteDio(TarefaDioModel model);
  delete(TarefaModel model);
}
