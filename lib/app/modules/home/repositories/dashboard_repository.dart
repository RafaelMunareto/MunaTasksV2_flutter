import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/shared/model/order_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';

class DashboardRepository implements IDashboardRepository {
  final FirebaseFirestore firestore;

  DashboardRepository({required this.firestore});

  void dispose() {}

  @override
  Stream<List<TarefaModel>> get() {
    return firestore.collection('tasks').orderBy('data').snapshots().map(
        (query) =>
            query.docs.map((doc) => TarefaModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<EtiquetaModel>> getEtiquetas() {
    return firestore.collection('etiqueta').snapshots().map((query) =>
        query.docs.map((doc) => EtiquetaModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<OrderModel>> getOrder() {
    return firestore.collection('order').snapshots().map((query) =>
        query.docs.map((doc) => OrderModel.fromDocument(doc)).toList());
  }

  @override
  Future<Stream<TarefaModel>> getByDocumentId(String documentId) async {
    return firestore
        .collection('tasks')
        .doc(documentId)
        .snapshots()
        .map((doc) => TarefaModel.fromDocument(doc));
  }

  @override
  delete(TarefaModel model) {
    model.reference!.delete();
  }

  @override
  Future save(TarefaModel model) async {
    if (model.reference == null) {
      model.reference = await firestore.collection('tasks').add(model.toMap());
    } else {
      model.reference!.update(model.toReverseMap());
    }
  }
}
