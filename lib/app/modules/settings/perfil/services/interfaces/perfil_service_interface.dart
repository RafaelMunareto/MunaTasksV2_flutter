import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';

abstract class IPerfilService {
  Stream<List<PerfilModel>> get();
  Future<PerfilDioModel> getDio(String id);
  Future<List<PerfilDioModel>> getDioList();
  Future<PerfilModel> getByDocumentId(String documentId);
  Future save(PerfilModel model);
  Future delete(PerfilModel model);
}
