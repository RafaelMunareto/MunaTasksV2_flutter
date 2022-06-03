import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/components/list_menu_widget.dart';
import 'package:munatasks2/app/shared/components/name_widget.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

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
                            Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: DrawerHeader(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: NameWidget(
                                          store: store,
                                          constraint: widget.constraint,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: ListMenuWidget(
                                          label: "Editar Perfil",
                                          rota: '/settings/perfil',
                                          icon: Icons.emoji_people,
                                        ),
                                      ),
                                      const ListMenuWidget(
                                        label: "Configurações",
                                        rota: '/settings/',
                                        icon: Icons.settings,
                                      ),
                                      const ListMenuWidget(
                                        label: "Etiquetas",
                                        rota: '/settings/etiquetas',
                                        icon: Icons.bookmark,
                                      ),
                                      const ListMenuWidget(
                                        label: "Tarefas",
                                        rota: '/home/tarefas',
                                        icon: Icons.people,
                                      ),
                                      const ListMenuWidget(
                                        label: "Privacy",
                                        rota: '/privacy/',
                                        icon: Icons.privacy_tip,
                                      ),
                                      ListMenuWidget(
                                        label: "Versão ${widget.version}",
                                        rota: '',
                                        icon: Icons.verified,
                                      ),
                                    ],
                                  ),
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
