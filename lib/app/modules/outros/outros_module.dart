import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/outros/changelog_page.dart';
import 'package:munatasks2/app/modules/outros/privacy_page.dart';

class OutrosModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/privacy", child: (_, args) => const PrivacyPage()),
    ChildRoute("/changelog", child: (_, args) => const ChangelogPage()),
  ];
}
