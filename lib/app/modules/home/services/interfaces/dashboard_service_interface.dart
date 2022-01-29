import 'package:munatasks2/app/modules/home/shared/model/order_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/prioridade_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

abstract class IDashboardService {
  Stream<List<TarefaModel>> get();
  Stream<List<EtiquetaModel>> getEtiquetas();
  Stream<List<OrderModel>> getOrder();
  Stream<List<UserModel>> getUsers();
  Stream<List<RetardModel>> getRetard();
  Stream<List<PrioridadeModel>> getPrioridade();
  Stream<List<SubtarefaInsertModel>> getSubtarefaInsert();
  Future save(TarefaModel model);
  delete(TarefaModel model);
}
