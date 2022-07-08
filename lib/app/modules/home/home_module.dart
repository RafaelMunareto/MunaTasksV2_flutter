import 'package:munatasks2/app/modules/home/tarefas/shared/controller/client_tarefas_store.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_create_store.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/dashboard_interfaces.dart';
import 'package:munatasks2/app/modules/home/repositories/dashboard_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/services/interfaces/dashboard_service_interface.dart';
import 'package:munatasks2/app/modules/home/services/dashboard_service.dart';
import 'package:munatasks2/app/shared/auth/repositories/guard.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ClientTarefasStore()),
    Bind.lazySingleton((i) => ClientStore()),
    Bind.lazySingleton((i) => ClientCreateStore()),
    Bind.lazySingleton<IDashboardService>(
        (i) => DashboardService(dashboardRepository: i.get())),
    Bind.lazySingleton<IDashboardRepository>((i) => DashboardRepository()),
    Bind.lazySingleton((i) => HomeStore(dashboardService: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, args) => const HomePage(),
        transition: TransitionType.rightToLeftWithFade,
        guards: [AuthGuard()]),
  ];
}
