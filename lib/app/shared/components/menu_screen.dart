import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/components/name_widget.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class MenuScreen extends StatefulWidget {
  final ZoomDrawerController controller;
  final bool open;
  final Function setOpen;
  final double constraint;
  final String version;

  const MenuScreen({
    Key? key,
    required this.controller,
    this.open = false,
    required this.setOpen,
    required this.constraint,
    required this.version,
  }) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final AuthController auth = Modular.get();
  final HomeStore store = Modular.get();
  final ILocalStorage storage = LocalStorageShare();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (widget.constraint < LarguraLayoutBuilder().telaPc) {
              widget.controller.toggle!();
              widget.setOpen(false);
            }
          },
          child: Padding(
            padding: widget.constraint >= LarguraLayoutBuilder().telaPc
                ? const EdgeInsets.all(16.0)
                : const EdgeInsets.all(0),
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icon/icon.png'),
                    opacity: 0.1,
                  ),
                ),
                child: widget.open
                    ? SizedBox(
                        width:
                            widget.constraint >= LarguraLayoutBuilder().telaPc
                                ? MediaQuery.of(context).size.width * 0.2
                                : MediaQuery.of(context).size.width,
                        child: ListView(
                          controller: ScrollController(),
                          padding: const EdgeInsets.all(8),
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: DrawerHeader(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    NameWidget(
                                      store: store,
                                      constraint: widget.constraint,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Modular.to.navigate('/settings/perfil');
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: AutoSizeText(
                                          "Edite Perfil",
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: store.client.theme
                                                ? darkThemeData(context)
                                                    .secondaryHeaderColor
                                                : lightThemeData(context)
                                                    .secondaryHeaderColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Row(
                                        children: const [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(
                                              Icons.settings,
                                            ),
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                              child: AutoSizeText(
                                                "Configurações",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Modular.to.navigate('/settings/');
                                      },
                                    ),
                                    ListTile(
                                      title: Row(
                                        children: const [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(Icons.bookmark),
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                              child: AutoSizeText(
                                                "Etiquetas",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Modular.to
                                            .navigate('/settings/etiquetas');
                                      },
                                    ),
                                    ListTile(
                                      title: Row(
                                        children: const [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(Icons.people),
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                              child: AutoSizeText(
                                                "Tarefas",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Modular.to.navigate('/home/tarefas');
                                      },
                                    ),
                                    ListTile(
                                      title: Row(
                                        children: const [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(Icons.privacy_tip),
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                              child: AutoSizeText(
                                                "Privacy",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Modular.to.navigate('/privacy/');
                                      },
                                    ),
                                    ListTile(
                                      title: Row(
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(Icons.verified),
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                              child: AutoSizeText(
                                                "Versão ${widget.version}",
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()),
          ),
        ),
      ),
    );
  }
}
