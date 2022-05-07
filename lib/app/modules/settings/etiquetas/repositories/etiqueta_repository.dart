import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/interfaces/etiqueta_interfaces.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
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
}
