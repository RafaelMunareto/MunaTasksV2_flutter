import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/repositories/dashboard_repository.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/home/shared/utils/functions_utils.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/components/list_menu_widget.dart';
import 'package:munatasks2/app/shared/components/logo_widget.dart';
import 'package:munatasks2/app/shared/components/name_widget.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MenuScreen extends StatefulWidget {
  final double constraint;

  const MenuScreen({
    Key? key,
    required this.constraint,
  }) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final AuthController auth = Modular.get();
  final ILocalStorage storage = LocalStorageShare();
  final ClientStore client = ClientStore();
  final ScrollController scrollController = ScrollController();
  final DashboardRepository dashboard = DashboardRepository();
  String version = '2.0.0';
  getVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
  }

  getPerfilAction() async {
    await storage.get('userDio').then((value) {
      if (value != null) {
        client.setUserDio(UserDioClientModel.fromJson(jsonDecode(value[0])));
      }
    }).then((value) async {
      await dashboard.getPerfil(client.userDio.id).then((value) {
        client.setPerfilUserlogado(value);
      }).catchError((erro) {
        FunctionsUtils().showErrors(erro);
      });
    });
  }

  @override
  void initState() {
    getPerfilAction();
    getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: widget.constraint >= LarguraLayoutBuilder().telaPc
              ? const EdgeInsets.all(16.0)
              : const EdgeInsets.all(0),
          child: SizedBox(
            width: widget.constraint >= LarguraLayoutBuilder().telaPc
                ? MediaQuery.of(context).size.width * 0.2
                : MediaQuery.of(context).size.width,
            child: ListView(
              controller: ScrollController(),
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: DrawerHeader(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: NameWidget(
                                      client: client,
                                      constraint: widget.constraint,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: ListMenuWidget(
                                      label: " Dashboard",
                                      rota: '/home/',
                                      icon: Icons.dashboard,
                                    ),
                                  ),
                                  const ListMenuWidget(
                                    label: " Editar Perfil",
                                    rota: '/settings/perfil',
                                    icon: Icons.emoji_people,
                                  ),
                                  const ListMenuWidget(
                                    label: " Configurações",
                                    rota: '/settings/',
                                    icon: Icons.settings,
                                  ),
                                  const ListMenuWidget(
                                    label: " Etiquetas",
                                    rota: '/settings/etiquetas',
                                    icon: Icons.bookmark,
                                  ),
                                  const ListMenuWidget(
                                    label: " Tarefas",
                                    rota: '/home/tarefas',
                                    icon: Icons.people,
                                  ),
                                  const ListMenuWidget(
                                    label: " Privacy",
                                    rota: '/outros/privacy',
                                    icon: Icons.privacy_tip,
                                  ),
                                  ListMenuWidget(
                                    label: " Versão $version",
                                    rota: '/outros/changelog',
                                    icon: Icons.verified,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          LogoWidget(constraint: widget.constraint),
                        ],
                      ),
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
