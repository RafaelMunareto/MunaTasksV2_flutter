import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/principal/repositories/interfaces/principal_interfaces.dart';
import 'package:munatasks2/app/modules/settings/principal/services/interfaces/principal_service_interface.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';

class PrincipalService extends Disposable implements IPrincipalService {
  final IPrincipalRepository principalRepository;

  PrincipalService({required this.principalRepository});

  @override
  void dispose() {}

  @override
  Future<SettingsModel> getSettings() {
    return principalRepository.getSettings();
  }

  @override
  Future updateSettings(SettingsModel model) {
    return principalRepository.updateSettings(model);
  }

  @override
  Future<SettingsUserModel> getSettingsUser(String id) {
    return principalRepository.getSettingsUser(id);
  }

  @override
  Future updateSettingsUser(SettingsUserModel model) {
    return principalRepository.updateSettingsUser(model);
  }
}
