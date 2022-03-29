import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/widget/equipes_widget.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/widget/imagem_perfil_widget.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/widget/names_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import 'package:rolling_switch/rolling_switch.dart';

class PerfilPage extends StatefulWidget {
  final String title;
  const PerfilPage({Key? key, this.title = 'Perfil'}) : super(key: key);
  @override
  PerfilPageState createState() => PerfilPageState();
}

class PerfilPageState extends State<PerfilPage> {
  final PerfilStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          context: context,
          icon: Icons.account_circle,
          settings: true,
          rota: '/home/',
          back: true),
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) {
            if (!store.client.loading) {
              bool enableSwitch = store.client.perfil.manager;
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: kIsWeb
                      ? const EdgeInsets.all(84.0)
                      : const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      ImagemPerfilWidget(errorName: store.client.validateName),
                      store.client.perfil.id.isEmpty
                          ? RollingSwitch.icon(
                              initialState: store.client.perfil.manager,
                              width: 200,
                              animationDuration:
                                  const Duration(milliseconds: 600),
                              onChanged: (bool state) {
                                setState(() {
                                  store.client.changeManager(state);
                                });
                                store.saveDio();
                              },
                              rollingInfoRight: RollingIconInfo(
                                backgroundColor:
                                    lightThemeData(context).primaryColor,
                                icon: Icons.work,
                                text: const Text(
                                  'Gerente',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              rollingInfoLeft: const RollingIconInfo(
                                backgroundColor: Colors.grey,
                                icon: Icons.engineering,
                                text: Text(
                                  'Técnico',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Container(),
                      NamesWidget(
                        enableSwitch: enableSwitch,
                        errorTime: store.client.validateTime,
                      ),
                      EquipesWidget(
                        enableSwitch: enableSwitch,
                      )
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
