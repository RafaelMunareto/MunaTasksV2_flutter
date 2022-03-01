import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';

abstract class IEtiquetaService {
  Stream<List<EtiquetaModel>> get();
  Future<List<EtiquetaDioModel>> getDio();
  Future<SettingsModel> getSettings();
  Stream<List<ColorsModel>> getColor();
  Future<EtiquetaModel> getByDocumentId(String documentId);
  Future save(EtiquetaModel model);
  Future delete(EtiquetaModel model);
  Future deleteDio(EtiquetaDioModel model);
  Future<EtiquetaDioModel> getDioByDocumentId(String documentId);
  Future saveDio(EtiquetaDioModel model);
}
