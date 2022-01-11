import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:rolling_switch/rolling_switch.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          icon: Icons.settings,
          context: context,
          settings: true,
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
                    title: const Text('Tema'),
                    trailing: RollingSwitch.icon(
                      key: Key(store.isSwitched.toString()),
                      initialState: store.isSwitched,
                      animationDuration: const Duration(milliseconds: 600),
                      onChanged: (bool state) {
                        setState(() {
                          AppWidget.of(context)!.changeTheme(
                              state ? ThemeMode.dark : ThemeMode.light);
                          store.changeSwitch(state);
                        });
                      },
                      rollingInfoRight: const RollingIconInfo(
                        backgroundColor: Colors.deepPurple,
                        icon: Icons.nights_stay,
                        text: Text(
                          'Dark',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      rollingInfoLeft: const RollingIconInfo(
                        backgroundColor: Colors.amber,
                        icon: Icons.wb_sunny,
                        text: Text(
                          'Light',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
