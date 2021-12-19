import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';

abstract class IPerfilService {
  Stream<List<PerfilModel>> get();
  Future<PerfilModel> getByDocumentId(String documentId);
  Future save(PerfilModel model);
  Future delete(PerfilModel model);
}
