import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class MenuScreen extends StatefulWidget {
  final ZoomDrawerController controller;
  final bool open;
  final Function setOpen;
  const MenuScreen(
      {Key? key,
      required this.controller,
      this.open = false,
      required this.setOpen})
      : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final AuthController auth = Modular.get();
  final HomeStore store = Modular.get();
  final ILocalStorage storage = LocalStorageShare();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              if (constraint.maxWidth < LarguraLayoutBuilder().telaPc &&
                  !Platform.isWindows) {
                widget.controller.toggle!();
                widget.setOpen(false);
              }
            },
            child: Padding(
              padding: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
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
                          width: constraint.maxWidth >=
                                  LarguraLayoutBuilder().telaPc
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 70.0,
                                        height: 70.0,
                                        decoration: store
                                                    .client
                                                    .perfilUserLogado
                                                    .urlImage !=
                                                ''
                                            ? BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    store
                                                        .client
                                                        .perfilUserLogado
                                                        .urlImage,
                                                  ),
                                                ),
                                              )
                                            : const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      'assets/img/person.png'),
                                                ),
                                              ),
                                      ),
                                      const Text(
                                        "Olá",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        store.client.perfilUserLogado.name.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: store.client.theme
                                              ? darkThemeData(context)
                                                  .primaryColor
                                              : lightThemeData(context)
                                                  .primaryColorDark,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Modular.to
                                              .navigate('/settings/perfil');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: Text(
                                            "Edite Perfil",
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
                                                child: Text(
                                                  "Configurações",
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                child: Text(
                                                  "Etiquetas",
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                      constraint.maxWidth <
                                              LarguraLayoutBuilder()
                                                      .telaSmartphone /
                                                  2.36
                                          ? ListTile(
                                              title: Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8.0),
                                                    child: Icon(
                                                        Icons.people_outline),
                                                  ),
                                                  Flexible(
                                                    child: SizedBox(
                                                      child: Text(
                                                        "Tarefas",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                Modular.to
                                                    .navigate('/home/tarefas');
                                              },
                                            )
                                          : Container(),
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
    });
  }
}
