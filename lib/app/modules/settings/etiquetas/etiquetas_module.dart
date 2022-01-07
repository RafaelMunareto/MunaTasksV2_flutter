import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_Page.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EtiquetasModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EtiquetasStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => EtiquetasPage()),
  ];
}
