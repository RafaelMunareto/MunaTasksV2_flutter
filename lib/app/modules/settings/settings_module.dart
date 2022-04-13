import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_page.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/etiqueta_repository.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/interfaces/etiqueta_interfaces.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/etiqueta_service.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/controller/etiqueta_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
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
import 'package:munatasks2/app/shared/utils/image/image_repository.dart';

class SettingsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ClientStore()),
    Bind.lazySingleton((i) => EtiquetaStore()),
    Bind.lazySingleton<IPerfilService>(
        (i) => PerfilService(perfilRepository: i.get())),
    Bind.lazySingleton<IPerfilRepository>((i) => PerfilRepository()),
    Bind.lazySingleton<IEtiquetaService>(
        (i) => EtiquetaService(etiquetaRepository: i.get())),
    Bind.lazySingleton<IEtiquetaRepository>((i) => EtiquetaRepository()),
    Bind.lazySingleton((i) => PrincipalStore(etiquetaService: i.get())),
    Bind.lazySingleton((i) => EtiquetasStore(etiquetaService: i.get())),
    Bind.lazySingleton<ImageRepository>((i) => ImageRepository()),
    Bind.lazySingleton(
        (i) => PerfilStore(perfilService: i.get(), imageRepository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => const PrincipalPage(), guards: [AuthGuard()]),
    ChildRoute('/perfil',
        child: (_, args) => const PerfilPage(),
        guards: [AuthGuard()],
        transition: TransitionType.leftToRightWithFade),
    ChildRoute('/etiquetas',
        child: (_, args) => const EtiquetasPage(),
        guards: [AuthGuard()],
        transition: TransitionType.leftToRightWithFade),
  ];
}
