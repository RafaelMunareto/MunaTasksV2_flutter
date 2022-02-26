import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';

abstract class IEtiquetaService {
  Stream<List<EtiquetaModel>> get();
  getDio();
  Stream<List<ColorsModel>> getColor();
  Future<EtiquetaModel> getByDocumentId(String documentId);
  Future save(EtiquetaModel model);
  Future delete(EtiquetaModel model);
}
