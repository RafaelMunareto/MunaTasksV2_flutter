import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';

abstract class IEtiquetaService {
  Future<List<EtiquetaDioModel>> getDio();
  Future<SettingsModel> getSettings();
  Future deleteDio(EtiquetaDioModel model);
  Future updateSettings(SettingsModel model);
  Future<SettingsUserModel> getSettingsUser(String id);
  Future updateSettingsUser(SettingsUserModel model);
  Future saveDio(EtiquetaDioModel model);
}
