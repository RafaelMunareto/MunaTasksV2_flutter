import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';

abstract class IPrincipalRepository {
  Future<SettingsModel> getSettings();
  Future<SettingsUserModel> getSettingsUser(String id);
  Future updateSettingsUser(SettingsUserModel model);
  Future updateSettings(SettingsModel model);
}
