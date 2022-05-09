import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/privacy/privacy_page.dart';

class PrivacyModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const PrivacyPage()),
  ];
}
