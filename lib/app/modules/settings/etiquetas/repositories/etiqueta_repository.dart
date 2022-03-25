import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/interfaces/etiqueta_interfaces.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class EtiquetaRepository implements IEtiquetaRepository {
  final FirebaseFirestore firestore;

  EtiquetaRepository({required this.firestore});

  void dispose() {}

  @override
  Stream<List<EtiquetaModel>> get() {
    return firestore.collection('etiqueta').orderBy('etiqueta').snapshots().map(
        (query) =>
            query.docs.map((doc) => EtiquetaModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<ColorsModel>> getColor() {
    return firestore.collection('color').snapshots().map((query) =>
        query.docs.map((doc) => ColorsModel.fromDocument(doc)).toList());
  }

  @override
  Future<EtiquetaModel> getByDocumentId(String documentId) async {
    return firestore
        .collection('etiqueta')
        .doc(documentId)
        .get()
        .then((doc) => EtiquetaModel.fromDocument(doc));
  }

  @override
  Future delete(EtiquetaModel model) {
    return model.reference!.delete();
  }

  @override
  Future save(EtiquetaModel model) async {
    if (model.reference == null) {
      model.reference = await firestore.collection('etiqueta').add({
        'etiqueta': model.etiqueta,
        'color': model.color,
        'icon': model.icon,
      });
    } else {
      model.reference!.update({
        'etiqueta': model.etiqueta,
        'color': model.color,
        'icon': model.icon,
      });
    }
  }

  @override
  Future<List<EtiquetaDioModel>> getDio() async {
    Response response;
    response = await DioStruture().dioAction().get('etiquetas');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      return EtiquetaDioModel.fromJson(e);
    }).toList();
  }

  @override
  Future<SettingsModel> getSettings() async {
    Response response;
    response = await DioStruture().dioAction().get('settings');
    DioStruture().statusRequest(response);
    var resposta = SettingsModel.fromJson(response.data[0]);
    return resposta;
  }

  @override
  Future deleteDio(EtiquetaDioModel model) async {
    Response response;
    response = await DioStruture().dioAction().delete('etiquetas/${model.id}');
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  Future<EtiquetaDioModel> getByDocumentIdDio(String documentId) async {
    Response response;
    response = await DioStruture().dioAction().get('etiquetas/$documentId');
    DioStruture().statusRequest(response);
    return EtiquetaDioModel.fromJson(response.data);
  }

  @override
  Future saveDio(EtiquetaDioModel model) async {
    Response response;
    if (model.id != null) {
      response = await DioStruture()
          .dioAction()
          .put('etiquetas/${model.id.toString()}', data: model);
      DioStruture().statusRequest(response);
      return response;
    } else {
      response = await DioStruture().dioAction().post('etiquetas', data: model);
      DioStruture().statusRequest(response);
      return response;
    }
  }
}
