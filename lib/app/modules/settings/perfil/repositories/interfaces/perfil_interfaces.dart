import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';

abstract class IPerfilRepository {
  Stream<List<PerfilModel>> get();
  Future save(PerfilModel model);
  Future delete(PerfilModel model);
  Future<PerfilModel> getByDocumentId(String documentId);
}
