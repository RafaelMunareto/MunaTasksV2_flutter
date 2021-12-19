import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/repositories/interfaces/perfil_interfaces.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/interfaces/perfil_service_interface.dart';

class PerfilService extends Disposable implements IPerfilService {
  final IPerfilRepository perfilRepository;

  PerfilService({required this.perfilRepository});

  @override
  void dispose() {}

  @override
  Stream<List<PerfilModel>> get() {
    return perfilRepository.get();
  }

  @override
  Future delete(PerfilModel model) {
    return perfilRepository.delete(model);
  }

  @override
  Future save(PerfilModel model) {
    return perfilRepository.save(model);
  }

  @override
  Future<PerfilModel> getByDocumentId(String documentId) {
    return perfilRepository.getByDocumentId(documentId);
  }
}
