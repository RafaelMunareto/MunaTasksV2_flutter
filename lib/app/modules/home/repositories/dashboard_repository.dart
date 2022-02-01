import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/shared/model/fase_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/order_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/prioridade_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

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
    return firestore.collection('etiqueta').orderBy('etiqueta').snapshots().map(
        (query) =>
            query.docs.map((doc) => EtiquetaModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<OrderModel>> getOrder() {
    return firestore.collection('order').snapshots().map((query) =>
        query.docs.map((doc) => OrderModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return firestore.collection('usuarios').orderBy('name').snapshots().map(
        (query) =>
            query.docs.map((doc) => UserModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<RetardModel>> getRetard() {
    return firestore.collection('retard').orderBy('tempoName').snapshots().map(
        (query) =>
            query.docs.map((doc) => RetardModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<FaseModel>> getFase() {
    return firestore.collection('fase').orderBy('name').snapshots().map(
        (query) =>
            query.docs.map((doc) => FaseModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<SubtarefaInsertModel>> getSubtarefaInsert() {
    return firestore
        .collection('subtarefa_insert')
        .orderBy('subtarefa')
        .snapshots()
        .map((query) => query.docs
            .map((doc) => SubtarefaInsertModel.fromDocument(doc))
            .toList());
  }

  @override
  Stream<List<PrioridadeModel>> getPrioridade() {
    return firestore
        .collection('prioridades')
        .orderBy('prioridade')
        .snapshots()
        .map((query) => query.docs
            .map((doc) => PrioridadeModel.fromDocument(doc))
            .toList());
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
  save(TarefaModel model) async {
    if (model.reference == null) {
      model.reference =
          await firestore.collection('tasks').add(model.toReverseMap());
    } else {
      model.reference!.update(model.toReverseMap());
    }
  }
}
