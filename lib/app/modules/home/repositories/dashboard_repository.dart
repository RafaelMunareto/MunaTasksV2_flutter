import 'package:dio/dio.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_dio_model.dart';
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
  Future<dynamic> saveDio(TarefaDioModel model) async {
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
