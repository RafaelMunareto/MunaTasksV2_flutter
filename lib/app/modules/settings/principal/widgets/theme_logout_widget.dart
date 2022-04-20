import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/app_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
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
              rollingInfoRight: RollingIconInfo(
                backgroundColor: store.isSwitched
                    ? darkThemeData(context).primaryColor
                    : lightThemeData(context).primaryColor,
                icon: Icons.nights_stay,
                text: const Text(
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
          ListTile(
            title: const Text('Logout'),
            trailing: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  store.isSwitched
                      ? darkThemeData(context).primaryColor
                      : lightThemeData(context).primaryColor,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    side: BorderSide(
                      color: store.isSwitched
                          ? darkThemeData(context).primaryColor
                          : lightThemeData(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                store.logoff();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text('Sair',
                    style: TextStyle(
                      color: store.isSwitched
                          ? darkThemeData(context).scaffoldBackgroundColor
                          : lightThemeData(context).scaffoldBackgroundColor,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
