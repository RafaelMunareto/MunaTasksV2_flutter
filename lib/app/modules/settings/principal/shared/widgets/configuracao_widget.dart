import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import "package:universal_html/html.dart" as html;
import 'package:url_launcher/url_launcher.dart';

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
              title: Text(
                'LOGOUT',
                style: TextStyle(
                    fontSize: widget.constraint >= LarguraLayoutBuilder().telaPc
                        ? 18
                        : 14),
              ),
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
                      maxLines: 1,
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
          widget.constraint < LarguraLayoutBuilder().telaPc
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: const AutoSizeText(
                      'VERSÃO DESKTOP',
                      maxLines: 1,
                    ),
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
                        launchUrl(Uri.parse(
                            'https://github.com/RafaelMunareto/MunaTasksV2_flutter/raw/main/assets/exe/Output/munatask.exe'));
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
                        child: AutoSizeText('BAIXAR',
                            maxLines: 1,
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
