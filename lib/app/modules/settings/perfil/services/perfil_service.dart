import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/repositories/interfaces/perfil_interfaces.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/interfaces/perfil_service_interface.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';

class PerfilService extends Disposable implements IPerfilService {
  final IPerfilRepository perfilRepository;

  PerfilService({required this.perfilRepository});

  @override
  void dispose() {}

  @override
  Future<PerfilDioModel> getDio(String id) {
    return perfilRepository.getDio(id);
  }

  @override
  Future<List<PerfilDioModel>> getDioList() {
    return perfilRepository.getDioList();
  }

  @override
  Future saveDio(PerfilDioModel model) {
    return perfilRepository.saveDio(model);
  }

  @override
  Future deleteDio(String id) {
    return perfilRepository.deleteDio(id);
  }

  @override
  Future saveName(PerfilDioModel model) {
    return perfilRepository.saveName(model);
  }
}
