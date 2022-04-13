import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/repositories/interfaces/perfil_interfaces.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class PerfilRepository implements IPerfilRepository {
  PerfilRepository();

  void dispose() {}

  @override
  Future<PerfilDioModel> getDio(String id) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/user/$id');
    DioStruture().statusRequest(response);
    return PerfilDioModel.fromJson(response.data[0]);
  }

  @override
  Future<List<PerfilDioModel>> getDioList() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      return PerfilDioModel.fromJson(e);
    }).toList();
  }

  @override
  saveDio(PerfilDioModel model) async {
    Response response;
    if (model.idStaff != null || model.idStaff.isNotEmpty) {
      try {
        model.idStaff[0].id;
      } catch (e) {
        model.idStaff =
            model.idStaff.map((e) => PerfilDioModel.fromJson(e)).toList();
      }
    }
    var dio = await DioStruture().dioAction();
    response = await dio.put('perfil/${model.id}', data: model.toJson(model));
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  saveName(PerfilDioModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    UserDioClientModel user = model.name;
    response = await dio
        .put('usuarios/user/${model.name.id}', data: {"name": user.name});
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  deleteDio(String id) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.delete('perfil/$id');
    DioStruture().statusRequest(response);
    return response;
  }
}
