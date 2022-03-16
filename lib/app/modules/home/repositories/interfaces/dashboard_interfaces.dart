import 'package:munatasks2/app/modules/home/shared/model/fase_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/order_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/prioridade_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

abstract class IDashboardRepository {
  Stream<List<TarefaModel>> get();
  Stream<List<EtiquetaModel>> getEtiquetas();
  Future<List<TarefaDioModel>> getDio();
  Stream<List<OrderModel>> getOrder();
  Stream<List<UserModel>> getUsers();
  Stream<List<RetardModel>> getRetard();
  Stream<List<PrioridadeModel>> getPrioridade();
  Stream<List<SubtarefaInsertModel>> getSubtarefaInsert();
  Stream<List<FaseModel>> getFase();
  save(TarefaModel model);
  delete(TarefaModel model);
  Future<Stream<TarefaModel>> getByDocumentId(String documentId);
}
