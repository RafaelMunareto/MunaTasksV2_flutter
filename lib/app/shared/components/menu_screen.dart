import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';

class MenuScreen extends StatefulWidget {
  final dynamic controller;
  const MenuScreen({Key? key, required this.controller}) : super(key: key);
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
              // image: DecorationImage(
              //   image: AssetImage('assets/img/fundo_gesun.png'),
              // ),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blueGrey,
                  Colors.white,
                ],
              ),
            ),
            child: ListView(
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
                              image:
                                  NetworkImage(auth.user!.photoURL.toString()),
                            ),
                          ),
                        ),
                        const Text(
                          "Olá",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
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
                          child: const Text(
                            "Edite Perfil",
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            "Home",
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 3.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Modular.to.navigate('/home');
                          },
                        ),
                        ListTile(
                          title: const Text(
                            "Configurações",
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 3.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Modular.to.navigate('/settings');
                          },
                        ),
                        ListTile(
                          title: const Text(
                            "Etiquetas",
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 3.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
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
            ),
          ),
        ),
      ),
    );
  }
}
