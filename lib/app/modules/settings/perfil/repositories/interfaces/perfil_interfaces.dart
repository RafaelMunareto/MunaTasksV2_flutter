import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';

abstract class IPerfilRepository {
  Stream<List<PerfilModel>> get();
  Future<PerfilDioModel> getDio(String id);
  Future<List<PerfilDioModel>> getDioList();
  Future save(PerfilModel model);
  Future delete(PerfilModel model);
  Future<PerfilModel> getByDocumentId(String documentId);
}
