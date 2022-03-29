import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/repositories/interfaces/perfil_interfaces.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class PerfilRepository implements IPerfilRepository {
  final FirebaseFirestore firestore;

  PerfilRepository({required this.firestore});

  void dispose() {}

  @override
  Stream<List<PerfilModel>> get() {
    return firestore.collection('perfil').snapshots().map((query) =>
        query.docs.map((doc) => PerfilModel.fromDocument(doc)).toList());
  }

  @override
  Future<PerfilModel> getByDocumentId(String documentId) async {
    return firestore
        .collection('perfil')
        .doc(documentId)
        .get()
        .then((doc) => PerfilModel.fromDocument(doc));
  }

  @override
  Future delete(PerfilModel model) {
    return model.reference!.delete();
  }

  @override
  Future save(PerfilModel model) async {
    if (model.reference == null) {
      model.reference = await firestore.collection('perfil').add({
        'idStaff': model.idStaff,
        'manager': model.manager,
        'name': model.name,
        'nameTime': model.nameTime,
      });
    } else {
      model.reference!.update({
        'idStaff': model.idStaff,
        'manager': model.manager,
        'name': model.name,
        'nameTime': model.nameTime,
      });
    }
  }

  @override
  Future<PerfilDioModel> getDio(String id) async {
    Response response;
    response = await DioStruture().dioAction().get('perfil/user/$id');
    DioStruture().statusRequest(response);
    return PerfilDioModel.fromJson(response.data[0]);
  }

  @override
  Future<List<PerfilDioModel>> getDioList() async {
    Response response;
    response = await DioStruture().dioAction().get('perfil');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      return PerfilDioModel.fromJson(e);
    }).toList();
  }

  @override
  saveDio(PerfilDioModel model) async {
    Response response;
    response = await DioStruture().dioAction().post('perfil', data: model);
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  updateDio(PerfilDioModel model) async {
    Response response;
    response =
        await DioStruture().dioAction().put('perfil/${model.id}', data: model);
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  deleteDio(String id) async {
    Response response;
    response = await DioStruture().dioAction().delete('perfil/$id');
    DioStruture().statusRequest(response);
    return response;
  }
}
