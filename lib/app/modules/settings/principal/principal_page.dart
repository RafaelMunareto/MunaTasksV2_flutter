import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';

import '../../../app_widget.dart';

class PrincipalPage extends StatefulWidget {
  final String title;
  const PrincipalPage({Key? key, this.title = 'Configurações'})
      : super(key: key);
  @override
  PrincipalPageState createState() => PrincipalPageState();
}

class PrincipalPageState extends State<PrincipalPage> {
  final PrincipalStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.buscaTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          icon: Icons.settings,
          context: context,
          rota: '/home'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(builder: (context, constraint) {
          double withDevice = constraint.maxWidth;

          if (withDevice < 600) {
            withDevice = withDevice * 1;
          } else if (withDevice < 960) {
            withDevice = withDevice * 0.7;
          } else if (withDevice < 1025) {
            withDevice = withDevice * 0.5;
          } else {
            withDevice = withDevice * 0.4;
          }
          return SizedBox(
            width: withDevice,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
              children: [
                Observer(builder: (_) {
                  return ListTile(
                    leading: const Icon(Icons.wb_sunny),
                    title: Switch(
                        value: store.isSwitched,
                        onChanged: (value) async {
                          await store.changeSwitch(value);
                          store.isSwitched
                              ? AppWidget.of(context)!
                                  .changeTheme(ThemeMode.dark)
                              : AppWidget.of(context)!
                                  .changeTheme(ThemeMode.light);
                        }),
                    trailing: const Icon(Icons.nights_stay),
                  );
                }),
                ListTile(
                  title: const Text('Logout'),
                  trailing: const Icon(Icons.logout),
                  onTap: () {
                    store.logoff();
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
