import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_page.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/repositories/interfaces/perfil_interfaces.dart';
import 'package:munatasks2/app/modules/settings/perfil/repositories/perfil_repository.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/interfaces/perfil_service_interface.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/perfil_service.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/shared/auth/repositories/guard.dart';

class SettingsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IPerfilService>(
        (i) => PerfilService(perfilRepository: i.get())),
    Bind.lazySingleton<IPerfilRepository>(
        (i) => PerfilRepository(firestore: FirebaseFirestore.instance)),
    Bind.lazySingleton((i) => PrincipalStore()),
    Bind.lazySingleton((i) => PerfilStore(perfilService: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => const PrincipalPage(), guards: [AuthGuard()]),
    ChildRoute('/perfil',
        child: (_, args) => const PerfilPage(), guards: [AuthGuard()]),
  ];
}
