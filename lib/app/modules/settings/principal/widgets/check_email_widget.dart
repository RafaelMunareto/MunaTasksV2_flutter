import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_user_model.dart';
import 'package:rolling_switch/rolling_switch.dart';

class CheckEmailWidget extends StatefulWidget {
  final String title;
  final SettingsUserModel settings;
  final Function update;
  const CheckEmailWidget(
      {Key? key,
      this.title = "CheckEmailWidget",
      required this.settings,
      required this.update})
      : super(key: key);

  @override
  State<CheckEmailWidget> createState() => _CheckEmailWidgetState();
}

class _CheckEmailWidgetState extends State<CheckEmailWidget> {
  bool emailInicial = true;
  bool emailFinal = true;
  bool mobile = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 150,
      child: Wrap(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            title: const Text('EMAIL - CRIAÇÃO'),
            trailing: RollingSwitch.icon(
              initialState: widget.settings.emailInicial == 's' ? true : false,
              animationDuration: const Duration(milliseconds: 600),
              onChanged: (bool state) {
                if (state) {
                  SettingsUserModel settings = SettingsUserModel(
                    user: widget.settings.user,
                    mobile: widget.settings.mobile,
                    emailFinal: widget.settings.emailFinal,
                    emailInicial: 's',
                  );
                  widget.update(settings);
                } else {
                  SettingsUserModel settings = SettingsUserModel(
                    user: widget.settings.user,
                    mobile: widget.settings.mobile,
                    emailFinal: widget.settings.emailFinal,
                    emailInicial: 'n',
                  );
                  widget.update(settings);
                }
              },
              rollingInfoRight: const RollingIconInfo(
                icon: Icons.check,
                text: Text(
                  'ON',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              rollingInfoLeft: const RollingIconInfo(
                backgroundColor: Colors.red,
                icon: Icons.close,
                text: Text(
                  'OFF',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            title: const Text('EMAIL - FINALIZAÇÃO'),
            trailing: RollingSwitch.icon(
              initialState: widget.settings.emailFinal == 's' ? true : false,
              animationDuration: const Duration(milliseconds: 600),
              onChanged: (bool state) {
                if (state) {
                  SettingsUserModel settings = SettingsUserModel(
                    user: widget.settings.user,
                    mobile: widget.settings.mobile,
                    emailFinal: 's',
                    emailInicial: widget.settings.emailInicial,
                  );
                  widget.update(settings);
                } else {
                  SettingsUserModel settings = SettingsUserModel(
                    user: widget.settings.user,
                    mobile: widget.settings.mobile,
                    emailFinal: 'n',
                    emailInicial: widget.settings.emailInicial,
                  );
                  widget.update(settings);
                }
              },
              rollingInfoRight: const RollingIconInfo(
                icon: Icons.check,
                text: Text(
                  'ON',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              rollingInfoLeft: const RollingIconInfo(
                backgroundColor: Colors.red,
                icon: Icons.close,
                text: Text(
                  'OFF',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            title: const Text('NOTIFICAÇÕES - MOBILE'),
            trailing: RollingSwitch.icon(
              initialState: widget.settings.mobile == 's' ? true : false,
              animationDuration: const Duration(milliseconds: 600),
              onChanged: (bool state) {
                if (state) {
                  SettingsUserModel settings = SettingsUserModel(
                    user: widget.settings.user,
                    mobile: 's',
                    emailFinal: widget.settings.emailFinal,
                    emailInicial: widget.settings.emailInicial,
                  );
                  widget.update(settings);
                } else {
                  SettingsUserModel settings = SettingsUserModel(
                    user: widget.settings.user,
                    mobile: 'n',
                    emailFinal: widget.settings.emailFinal,
                    emailInicial: widget.settings.emailInicial,
                  );
                  widget.update(settings);
                }
              },
              rollingInfoRight: const RollingIconInfo(
                icon: Icons.check,
                text: Text(
                  'ON',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              rollingInfoLeft: const RollingIconInfo(
                backgroundColor: Colors.red,
                icon: Icons.close,
                text: Text(
                  'OFF',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
