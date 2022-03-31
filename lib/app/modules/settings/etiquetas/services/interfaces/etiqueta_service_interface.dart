import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';

abstract class IEtiquetaService {
  Future<List<EtiquetaDioModel>> getDio();
  Future<SettingsModel> getSettings();
  Future deleteDio(EtiquetaDioModel model);
  Future saveDio(EtiquetaDioModel model);
}
