import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/tarefas/tarefas_page.dart';
import 'package:munatasks2/app/modules/home/tarefas/tarefas_store.dart';
import 'package:munatasks2/app/shared/auth/repositories/guard.dart';

class TarefasModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TarefasStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, args) => const TarefasPage(), guards: [AuthGuard()]),
  ];
}
