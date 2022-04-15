import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/interfaces/etiqueta_interfaces.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class EtiquetaRepository implements IEtiquetaRepository {
  EtiquetaRepository();

  void dispose() {}

  @override
  Future<List<EtiquetaDioModel>> getDio() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('etiquetas');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      return EtiquetaDioModel.fromJson(e);
    }).toList();
  }

  @override
  Future<SettingsModel> getSettings() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('settings');
    DioStruture().statusRequest(response);
    var resposta = SettingsModel.fromJson(response.data[0]);
    return resposta;
  }

  @override
  Future deleteDio(EtiquetaDioModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.delete('etiquetas/${model.id}');
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  Future<EtiquetaDioModel> getByDocumentIdDio(String documentId) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('etiquetas/$documentId');
    DioStruture().statusRequest(response);
    return EtiquetaDioModel.fromJson(response.data);
  }

  @override
  Future saveDio(EtiquetaDioModel model) async {
    Response response;
    if (model.id != null) {
      var dio = await DioStruture().dioAction();
      response = await dio.put('etiquetas/${model.id.toString()}', data: model);
      DioStruture().statusRequest(response);
      return response;
    } else {
      var dio = await DioStruture().dioAction();
      response = await dio.post('etiquetas', data: model);
      DioStruture().statusRequest(response);
      return response;
    }
  }

  @override
  Future updateSettings(SettingsModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    model.retard = model.retard!.map((e) {
      return e.toJson(e);
    }).toList();
    response = await dio.put('settings/${model.id}', data: model.toJson(model));
    DioStruture().statusRequest(response);
    return response;
  }
}
