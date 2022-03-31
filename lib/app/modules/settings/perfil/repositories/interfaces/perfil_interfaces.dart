import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';

abstract class IPerfilRepository {
  Future<PerfilDioModel> getDio(String id);
  Future<List<PerfilDioModel>> getDioList();
  Future saveDio(PerfilDioModel model);
  Future deleteDio(String id);
}
