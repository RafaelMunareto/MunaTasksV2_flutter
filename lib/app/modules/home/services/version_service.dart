

import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/models/version_model.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/version_interfaces.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/version_service_interface.dart';

class VersionService extends Disposable implements IVersionService{

  final IVersionRepository versionRepository;

  VersionService({required this.versionRepository});

  @override
  void dispose() {}

  @override
  Stream<List<VersionModel>> get() {
    return versionRepository.get();
  }

  @override
  Future delete(VersionModel model) {
    return versionRepository.delete(model);
  }

  @override
  Future save(VersionModel model) {
    return versionRepository.save(model);
  }


}