import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';

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
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (!kIsWeb) {
              widget.controller.toggle!();
              widget.setOpen(false);
            }
          },
          child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon/icon.png'),
                  opacity: 0.4,
                ),
              ),
              child: widget.open
                  ? SizedBox(
                      width: kIsWeb
                          ? MediaQuery.of(context).size.width * 0.2
                          : MediaQuery.of(context).size.width,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: DrawerHeader(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  store.client.perfilUserLogado.urlImage.isEmpty
                                      ? const CircularProgressIndicator()
                                      : Container(
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(store.client
                                                  .perfilUserLogado.urlImage),
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
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Modular.to.navigate('/settings/perfil');
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(bottom: 16.0),
                                      child: Text(
                                        "Edite Perfil",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.settings,
                                          ),
                                        ),
                                        Flexible(
                                          child: SizedBox(
                                            child: Text(
                                              "Configurações",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Modular.to.navigate('/settings');
                                    },
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.bookmark,
                                          ),
                                        ),
                                        Flexible(
                                          child: SizedBox(
                                            child: Text(
                                              "Etiquetas",
                                              overflow: TextOverflow.ellipsis,
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
    );
  }
}
