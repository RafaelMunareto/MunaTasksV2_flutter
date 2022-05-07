import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/widgets/configuracao_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/widgets/dialog_input_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/widgets/dropdown_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:rolling_switch/rolling_switch.dart';

import 'list_settings_widget.dart';

class CheckEmailWidget extends StatefulWidget {
  final double constraint;
  const CheckEmailWidget({
    Key? key,
    required this.constraint,
  }) : super(key: key);

  @override
  State<CheckEmailWidget> createState() => _CheckEmailWidgetState();
}

class _CheckEmailWidgetState extends State<CheckEmailWidget> {
  final PrincipalStore store = Modular.get();
  bool emailInicial = true;
  bool emailFinal = true;
  bool mobile = true;

  update() {
    SettingsUserModel settingsLoad = SettingsUserModel(
      user: store.client.settingsUser.user,
      emailFinal: emailFinal,
      emailInicial: emailInicial,
      mobile: mobile,
    );
    store.updateSettingsUser(settingsLoad);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      emailInicial = store.client.settingsUser.emailInicial;
      emailFinal = store.client.settingsUser.emailFinal;
      mobile = store.client.settingsUser.mobile;
    });

    return Wrap(children: [
      ConfiguracaoWidget(constraint: widget.constraint),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          title: const Text('EMAIL - CRIAÇÃO'),
          trailing: RollingSwitch.icon(
            initialState: emailInicial,
            animationDuration: const Duration(milliseconds: 600),
            onChanged: (bool state) {
              if (state) {
                emailInicial = state;
                update();
              }
            },
            rollingInfoRight: const RollingIconInfo(
              icon: Icons.check,
              text: Text(
                'ON',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            initialState: emailFinal,
            animationDuration: const Duration(milliseconds: 600),
            onChanged: (bool state) {
              setState(() {
                emailFinal = state;
                update();
              });
            },
            rollingInfoRight: const RollingIconInfo(
              icon: Icons.check,
              text: Text(
                'ON',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            initialState: mobile,
            animationDuration: const Duration(milliseconds: 600),
            onChanged: (bool state) {
              setState(() {
                mobile = state;
                update();
              });
            },
            rollingInfoRight: const RollingIconInfo(
              icon: Icons.check,
              text: Text(
                'ON',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      ListTile(
        tileColor: Colors.blue,
        leading: const DropdownWidget(),
        trailing: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.add),
          onPressed: () => {
            DialogButtom().showDialog(
              DialogInputWidget(
                value: '',
                create: 'Novo',
                editar: store.novo,
                constraint: widget.constraint,
              ),
              store.client.isSwitched,
              widget.constraint,
              context,
            ),
            store.client.setValueEscolha('')
          },
        ),
      ),
      ListSettingsWidget(
        constraint: widget.constraint,
      ),
    ]);
  }
}
