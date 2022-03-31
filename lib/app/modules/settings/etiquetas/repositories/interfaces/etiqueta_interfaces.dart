import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';

abstract class IEtiquetaRepository {
  Future<List<EtiquetaDioModel>> getDio();
  Future<SettingsModel> getSettings();
  Future saveDio(EtiquetaDioModel model);
  Future deleteDio(EtiquetaDioModel model);
  Future<EtiquetaDioModel> getByDocumentIdDio(String documentId);
}
