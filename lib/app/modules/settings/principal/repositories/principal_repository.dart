import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/principal/repositories/interfaces/principal_interfaces.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class PrincipalRepository implements IPrincipalRepository {
  PrincipalRepository();

  void dispose() {}

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

  @override
  Future<SettingsUserModel> getSettingsUser(String id) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/settingsUser/$id');
    DioStruture().statusRequest(response);
    if (response.data.isEmpty) {
      SettingsUserModel settings = SettingsUserModel(user: id);
      saveSettings(settings);
    } else {
      return SettingsUserModel.fromJson(response.data[0]);
    }
    SettingsUserModel settings = SettingsUserModel(user: id);
    return settings;
  }

  @override
  Future updateSettingsUser(SettingsUserModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.put('perfil/settingsUser/${model.user}',
        data: model.toJson(model));
    DioStruture().statusRequest(response);
    return response;
  }

  Future saveSettings(SettingsUserModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.post('perfil/settingsUser', data: model.toJson(model));
    DioStruture().statusRequest(response);
    return response;
  }
}
