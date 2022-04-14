import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/app_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:rolling_switch/rolling_switch.dart';

class ThemeLogoutWidget extends StatefulWidget {
  const ThemeLogoutWidget({Key? key}) : super(key: key);

  @override
  State<ThemeLogoutWidget> createState() => _ThemeLogoutWidgetState();
}

class _ThemeLogoutWidgetState extends State<ThemeLogoutWidget> {
  final PrincipalStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: const Text('Tema'),
            trailing: RollingSwitch.icon(
              initialState: store.isSwitched,
              animationDuration: const Duration(milliseconds: 600),
              onChanged: (bool state) {
                setState(() {
                  AppWidget.of(context)!
                      .changeTheme(state ? ThemeMode.dark : ThemeMode.light);
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
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: const Text('Logout'),
              trailing: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                      side: const BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'Sair',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              onTap: () {
                store.logoff();
              },
            ),
          )
        ],
      ),
    );
  }
}
