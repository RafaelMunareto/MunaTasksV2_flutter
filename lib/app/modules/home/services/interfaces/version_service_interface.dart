import 'package:munatasks2/app/modules/home/models/version_model.dart';

abstract class IVersionService{
  Stream<List<VersionModel>> get();
  Future save(VersionModel model);
  Future delete(VersionModel model);
}