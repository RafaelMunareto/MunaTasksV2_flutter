import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/interfaces/etiqueta_interfaces.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';

class EtiquetaService extends Disposable implements IEtiquetaService {
  final IEtiquetaRepository etiquetaRepository;

  EtiquetaService({required this.etiquetaRepository});

  @override
  void dispose() {}

  @override
  Future<List<EtiquetaDioModel>> getDio() {
    return etiquetaRepository.getDio();
  }

  @override
  Future deleteDio(EtiquetaDioModel model) {
    return etiquetaRepository.deleteDio(model);
  }

  @override
  Future saveDio(EtiquetaDioModel model) {
    return etiquetaRepository.saveDio(model);
  }

  @override
  Future<SettingsModel> getSettings() {
    return etiquetaRepository.getSettings();
  }
}
