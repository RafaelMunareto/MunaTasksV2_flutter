import 'package:munatasks2/app/modules/create/create_Page.dart';
import 'package:munatasks2/app/modules/create/create_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreateStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CreatePage()),
  ];
}
