import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';

class DashboardRepository implements IDashboardRepository {
  final FirebaseFirestore firestore;

  DashboardRepository({required this.firestore});

  void dispose() {}

  @override
  Stream<List<TarefaModel>> get() {
    return firestore.collection('tarefa').snapshots().map((query) =>
        query.docs.map((doc) => TarefaModel.fromDocument(doc)).toList());
  }

  @override
  Future<Stream<TarefaModel>> getByDocumentId(String documentId) async {
    return firestore
        .collection('tarefa')
        .doc(documentId)
        .snapshots()
        .map((doc) => TarefaModel.fromDocument(doc));
  }

  @override
  Future delete(TarefaModel model) {
    return model.reference!.delete();
  }

  @override
  Future save(TarefaModel model) async {
    if (model.reference == null) {
      model.reference = await firestore.collection('tarefa').add({
        'etiqueta': model.etiqueta,
        'texto': model.texto,
        'data': model.data,
        'users': model.users!.map((e) => e?.toMap()).toList(),
        'subtarefaModel': model.subTarefa!.map((e) => e.toMap()).toList()
      });
    } else {
      model.reference!.update({
        'etiqueta': model.etiqueta,
        'texto': model.texto,
        'data': model.data,
        'users': model.users!.map((e) => e?.toMap()).toList(),
        'subtarefaModel': model.subTarefa!.map((e) => e.toMap()).toList()
      });
    }
  }
}
