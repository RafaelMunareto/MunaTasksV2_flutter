import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';

abstract class IPerfilRepository {
  Future<PerfilDioModel> getDio(String id);
  Future<List<PerfilDioModel>> getDioList();
  Future saveDio(PerfilDioModel model);
  Future saveName(PerfilDioModel model);
  Future deleteDio(String id);
}
