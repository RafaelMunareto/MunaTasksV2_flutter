import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/repositories/interfaces/perfil_interfaces.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class PerfilRepository implements IPerfilRepository {
  PerfilRepository();

  void dispose() {}

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
    Response response2;
    response = await DioStruture()
        .dioAction()
        .put('usuarios/user/${model.name.id}', data: {"name": model.name.name});
    DioStruture().statusRequest(response);
    response2 = await DioStruture()
        .dioAction()
        .put('perfil/${model.id}', data: model.toJson(model));
    DioStruture().statusRequest(response2);
    return response2;
  }

  @override
  deleteDio(String id) async {
    Response response;
    response = await DioStruture().dioAction().delete('perfil/$id');
    DioStruture().statusRequest(response);
    return response;
  }
}
