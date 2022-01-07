import 'package:munatasks2/app/modules/settings/etiquetas/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';

abstract class IEtiquetaRepository {
  Stream<List<PerfilModel>> get();
  Stream<List<ColorsModel>> getColor();
  Future save(PerfilModel model);
  Future delete(PerfilModel model);
  Future<PerfilModel> getByDocumentId(String documentId);
}
