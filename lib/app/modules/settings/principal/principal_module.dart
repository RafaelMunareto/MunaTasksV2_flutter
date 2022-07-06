import 'package:munatasks2/app/modules/settings/principal/principal_page.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PrincipalModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PrincipalStore(principalService: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const PrincipalPage()),
  ];
}
