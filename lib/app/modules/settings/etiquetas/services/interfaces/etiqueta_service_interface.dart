import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';

abstract class IEtiquetaService {
  Future<List<EtiquetaDioModel>> getDio();
  Future deleteDio(EtiquetaDioModel model);
  Future saveDio(EtiquetaDioModel model);
  Future<EtiquetaDioModel> getByDocumentIdDio(String documentId);
}
