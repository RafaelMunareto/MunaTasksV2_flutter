import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';

class MenuScreen extends StatefulWidget {
  final dynamic controller;
  final bool open;
  const MenuScreen({Key? key, required this.controller, this.open = false})
      : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final AuthController auth = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => widget.controller.toggle!(),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icon/icon.png'),
                opacity: 0.4,
              ),
            ),
            child: widget.open
                ? ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: DrawerHeader(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        auth.user!.photoURL.toString()),
                                  ),
                                ),
                              ),
                              const Text(
                                "Olá",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                auth.user!.displayName.toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
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
                                    Text("Configurações"),
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
                                    Text(
                                      "Etiquetas",
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Modular.to.navigate('/settings/etiquetas');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        ),
      ),
    );
  }
}