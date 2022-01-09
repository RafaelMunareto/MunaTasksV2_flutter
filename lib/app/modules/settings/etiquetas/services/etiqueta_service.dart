import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/interfaces/etiqueta_interfaces.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';

class EtiquetaService extends Disposable implements IEtiquetaService {
  final IEtiquetaRepository etiquetaRepository;

  EtiquetaService({required this.etiquetaRepository});

  @override
  void dispose() {}

  @override
  Stream<List<EtiquetaModel>> get() {
    return etiquetaRepository.get();
  }

  @override
  Stream<List<ColorsModel>> getColor() {
    return etiquetaRepository.getColor();
  }

  @override
  Future delete(EtiquetaModel model) {
    return etiquetaRepository.delete(model);
  }

  @override
  Future save(EtiquetaModel model) {
    return etiquetaRepository.save(model);
  }

  @override
  Future<EtiquetaModel> getByDocumentId(String documentId) {
    return etiquetaRepository.getByDocumentId(documentId);
  }
}
