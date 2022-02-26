import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';

abstract class IEtiquetaRepository {
  Stream<List<EtiquetaModel>> get();
  getDio();
  Stream<List<ColorsModel>> getColor();
  Future save(EtiquetaModel model);
  Future delete(EtiquetaModel model);
  Future<EtiquetaModel> getByDocumentId(String documentId);
}
