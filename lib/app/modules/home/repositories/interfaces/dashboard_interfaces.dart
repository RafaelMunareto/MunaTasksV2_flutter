import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';

abstract class IDashboardRepository {
  Stream<List<TarefaModel>> get();
  Future save(TarefaModel model);
  delete(TarefaModel model);
  Future<Stream<TarefaModel>> getByDocumentId(String documentId);
}
