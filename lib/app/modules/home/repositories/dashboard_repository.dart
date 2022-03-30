import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/shared/model/fase_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_total_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class DashboardRepository implements IDashboardRepository {
  final FirebaseFirestore firestore;
  final ILocalStorage storage = LocalStorageShare();
  DashboardRepository({required this.firestore});

  void dispose() {}

  @override
  Stream<List<TarefaModel>> get() {
    return firestore.collection('tasks').orderBy('data').snapshots().map(
          (query) => query.docs
              .map(
                (doc) => TarefaModel.fromDocument(doc),
              )
              .toSet()
              .toList(),
        );
  }

  @override
  Stream<List<EtiquetaModel>> getEtiquetas() {
    return firestore.collection('etiqueta').orderBy('etiqueta').snapshots().map(
        (query) =>
            query.docs.map((doc) => EtiquetaModel.fromDocument(doc)).toList());
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

  @override
  Future<List<TarefaDioModel>> getDio(String id, int fase) async {
    Response response;
    response = await DioStruture().dioAction().get('tasks/fase/$id/$fase');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      e = TarefaDioModel.fromJson(e);
      e.users = e.users!.map((u) {
        return PerfilDioModel.fromJson(u);
      }).toList();
      e.subTarefa = e.subTarefa!.map((f) {
        return SubtareDiofaModel.fromJson(f);
      }).toList();
      e.data = DateTime.parse(e.data);

      return e as TarefaDioModel;
    }).toList();
  }

  @override
  Future<List<TarefaDioModel>> getDioIndividual(String id) async {
    Response response;
    response = await DioStruture().dioAction().get('tasks/individual/$id');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      e = TarefaDioModel.fromJson(e);
      e.users = e.users!.map((u) {
        return PerfilDioModel.fromJson(u);
      }).toList();
      e.subTarefa = e.subTarefa!.map((f) {
        return SubtareDiofaModel.fromJson(f);
      }).toList();
      e.data = DateTime.parse(e.data);
      return e as TarefaDioModel;
    }).toList();
  }

  @override
  Future<List<TarefaDioTotalModel>> getDioTotal() async {
    Response response;
    response = await DioStruture().dioAction().get('tasks/total');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      e = TarefaDioTotalModel.fromJson(e);
      e.name = PerfilDioModel.fromJson(e.name);
      e.tarefa = e.tarefa!.map((u) {
        return TarefaDioModel.fromJson(u);
      }).toList();
      return e as TarefaDioTotalModel;
    }).toList();
  }

  @override
  saveDio(TarefaDioModel model) async {
    Response response;
    response = await DioStruture()
        .dioAction()
        .post('tasks', data: model.toJson(model));
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  updateDio(TarefaDioModel model) async {
    Response response;
    response = await DioStruture()
        .dioAction()
        .put('tasks/${model.id.toString()}', data: model.toJson(model));
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  deleteDio(TarefaDioModel model) async {
    Response response;
    response = await DioStruture().dioAction().delete('tasks/${model.id}');
    DioStruture().statusRequest(response);
    return response;
  }
}
