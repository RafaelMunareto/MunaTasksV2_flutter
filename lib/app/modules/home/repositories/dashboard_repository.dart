import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/shared/model/notifications_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefas_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_total_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class DashboardRepository implements IDashboardRepository {
  DashboardRepository();

  void dispose() {}

  @override
  Future<List<TarefaDioModel>> getDio(String id, int fase) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('tasks/fase/$id/$fase');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      e = TarefaDioModel.fromJson(e);
      e.users = e.users!.map((u) {
        return PerfilDioModel.fromJson(u);
      }).toList();
      e.subTarefa = e.subTarefa!.map((f) {
        return SubtarefasDioModel.fromJson(f);
      }).toList();
      e.data = DateTime.parse(e.data);

      return e as TarefaDioModel;
    }).toList();
  }

  @override
  Future<List<TarefaDioModel>> getDioIndividual(String id) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('tasks/individual/$id');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      e = TarefaDioModel.fromJson(e);
      e.users = e.users!.map((u) {
        return PerfilDioModel.fromJson(u);
      }).toList();
      e.subTarefa = e.subTarefa!.map((f) {
        return SubtarefasDioModel.fromJson(f);
      }).toList();
      e.data = DateTime.parse(e.data);
      return e as TarefaDioModel;
    }).toList();
  }

  @override
  Future<List<TarefaDioModel>> getFilterUser(String id) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('tasks/filter_user/$id');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      e = TarefaDioModel.fromJson(e);
      e.users = e.users!.map((u) {
        return PerfilDioModel.fromJson(u);
      }).toList();
      e.subTarefa = e.subTarefa!.map((f) {
        return SubtarefasDioModel.fromJson(f);
      }).toList();
      e.data = DateTime.parse(e.data);
      return e as TarefaDioModel;
    }).toList();
  }

  @override
  Future<List<TarefaDioTotalModel>> getDioTotal() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('tasks/total');
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
  Future<dynamic> saveDio(TarefaDioModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.post('tasks', data: model.toJson(model));
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  updateDio(TarefaDioModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.put('tasks/${model.id.toString()}',
        data: model.toJson(model));
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  deleteDio(TarefaDioModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.delete('tasks/${model.id}');
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  deleteNotifications(String id) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.delete('tasks/notifications/$id');
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  Future<List<NotificationsDioModel>> getNotifications(String id) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('tasks/notifications/$id');
    DioStruture().statusRequest(response);

    return (response.data as List).map((value) {
      value = NotificationsDioModel.fromJson(value);
      return value as NotificationsDioModel;
    }).toList();
  }

  @override
  Future emailDio(String id, String tipo) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('tasks/new_email/$id/$tipo');
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  Future<List<PerfilDioModel>> getPerfis() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      return PerfilDioModel.fromJson(e);
    }).toList();
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
      return settings;
    } else {
      return SettingsUserModel.fromJson(response.data[0]);
    }
  }

  @override
  saveSettings(model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.post('perfil/settingsUser', data: model.toJson(model));
    DioStruture().statusRequest(response);
    return response;
  }

  @override
  Future<SettingsModel> getSettings() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('settings');
    DioStruture().statusRequest(response);
    return SettingsModel.fromJson(response.data[0]);
  }

  @override
  Future<List<EtiquetaDioModel>> getEtiquetas() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('etiquetas');
    DioStruture().statusRequest(response);
    return (response.data as List).map((e) {
      return EtiquetaDioModel.fromJson(e);
    }).toList();
  }

  @override
  Future<PerfilDioModel> getPerfil(String id) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/user/$id');
    DioStruture().statusRequest(response);
    return PerfilDioModel.fromJson(response.data[0]);
  }
}
