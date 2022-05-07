import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';

abstract class IPrincipalService {
  Future<SettingsModel> getSettings();
  Future updateSettings(SettingsModel model);
  Future<SettingsUserModel> getSettingsUser(String id);
  Future updateSettingsUser(SettingsUserModel model);
}
