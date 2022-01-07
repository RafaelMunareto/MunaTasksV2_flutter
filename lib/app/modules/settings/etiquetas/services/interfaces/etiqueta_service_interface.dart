import 'package:munatasks2/app/modules/settings/etiquetas/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';

abstract class IEtiquetaService {
  Stream<List<PerfilModel>> get();
  Stream<List<ColorsModel>> getColor();
  Future<PerfilModel> getByDocumentId(String documentId);
  Future save(PerfilModel model);
  Future delete(PerfilModel model);
}
