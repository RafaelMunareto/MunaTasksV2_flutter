import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/app_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import 'package:rolling_switch/rolling_switch.dart';
import "package:universal_html/html.dart" as html;

class ConfiguracaoWidget extends StatefulWidget {
  final double constraint;
  const ConfiguracaoWidget({
    Key? key,
    required this.constraint,
  }) : super(key: key);

  @override
  State<ConfiguracaoWidget> createState() => _ConfiguracaoWidgetState();
}

class _ConfiguracaoWidgetState extends State<ConfiguracaoWidget> {
  final PrincipalStore store = Modular.get();

  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              title: const Text('LOGOUT'),
              trailing: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    store.client.isSwitched
                        ? darkThemeData(context).primaryColor
                        : lightThemeData(context).primaryColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                      side: BorderSide(
                        color: store.client.isSwitched
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
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Text('SAIR',
                      style: TextStyle(
                        fontSize: 18,
                        color: store.client.isSwitched
                            ? darkThemeData(context).scaffoldBackgroundColor
                            : lightThemeData(context).scaffoldBackgroundColor,
                      )),
                ),
              ),
            ),
          ),
          widget.constraint <= LarguraLayoutBuilder().telaSmartphone
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: const Text('VERSÃO DESKTOP'),
                    trailing: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          store.client.isSwitched
                              ? darkThemeData(context).primaryColor
                              : lightThemeData(context).primaryColor,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                            side: BorderSide(
                              color: store.client.isSwitched
                                  ? darkThemeData(context).primaryColor
                                  : lightThemeData(context).primaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        downloadFile(
                            'https://github.com/RafaelMunareto/MunaTasksV2_flutter/raw/main/assets/exe/Output/munatask.exe');
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
                        child: Text('BAIXAR',
                            style: TextStyle(
                              fontSize: 18,
                              color: store.client.isSwitched
                                  ? darkThemeData(context)
                                      .scaffoldBackgroundColor
                                  : lightThemeData(context)
                                      .scaffoldBackgroundColor,
                            )),
                      ),
                    ),
                  ),
                ),
        ],
      );
    });
  }
}
