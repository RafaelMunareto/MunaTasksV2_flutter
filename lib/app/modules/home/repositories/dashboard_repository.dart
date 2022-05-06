import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/shared/model/notifications_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefas_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_total_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class DashboardRepository implements IDashboardRepository {
  final ILocalStorage storage = LocalStorageShare();
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
    emailDio(response.data['id'], '0');
    return response;
  }

  @override
  updateDio(TarefaDioModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.put('tasks/${model.id.toString()}',
        data: model.toJson(model));
    if (model.fase == 2) {
      emailDio(model.id.toString(), '1');
    }
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
}
