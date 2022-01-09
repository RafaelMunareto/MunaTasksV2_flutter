import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_page.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/etiqueta_repository.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/interfaces/etiqueta_interfaces.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/etiqueta_service.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
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
    Bind.lazySingleton((i) => ClientStore()),
    Bind.lazySingleton<IPerfilService>(
        (i) => PerfilService(perfilRepository: i.get())),
    Bind.lazySingleton<IPerfilRepository>(
        (i) => PerfilRepository(firestore: FirebaseFirestore.instance)),
    Bind.lazySingleton<IEtiquetaService>(
        (i) => EtiquetaService(etiquetaRepository: i.get())),
    Bind.lazySingleton<IEtiquetaRepository>(
        (i) => EtiquetaRepository(firestore: FirebaseFirestore.instance)),
    Bind.lazySingleton((i) => PrincipalStore()),
    Bind.lazySingleton((i) => EtiquetasStore(etiquetaService: i.get())),
    Bind.lazySingleton(
        (i) => PerfilStore(perfilService: i.get(), imageRepository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => const PrincipalPage(), guards: [AuthGuard()]),
    ChildRoute('/perfil',
        child: (_, args) => const PerfilPage(), guards: [AuthGuard()]),
    ChildRoute('/etiquetas',
        child: (_, args) => const EtiquetasPage(), guards: [AuthGuard()]),
  ];
}
