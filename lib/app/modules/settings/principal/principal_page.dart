import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:rolling_switch/rolling_switch.dart';

import '../../../app_widget.dart';

class PrincipalPage extends StatefulWidget {
  final String title;
  const PrincipalPage({Key? key, this.title = 'Configurações'})
      : super(key: key);
  @override
  PrincipalPageState createState() => PrincipalPageState();
}

class PrincipalPageState extends State<PrincipalPage> {
  final PrincipalStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          icon: Icons.settings,
          context: context,
          settings: true,
          rota: '/home/'),
      body: Observer(
        builder: (_) {
          return store.finalize
              ? Padding(
                  padding:
                      kIsWeb && defaultTargetPlatform == TargetPlatform.windows
                          ? const EdgeInsets.all(16.0)
                          : const EdgeInsets.all(0),
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        double withDevice = constraint.maxWidth;

                        if (withDevice < 600) {
                          withDevice = withDevice * 1;
                        } else if (withDevice < 960) {
                          withDevice = withDevice * 0.7;
                        } else if (withDevice < 1025) {
                          withDevice = withDevice * 0.5;
                        } else {
                          withDevice = withDevice * 0.5;
                        }
                        return SizedBox(
                          width: withDevice,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ListView(
                                  children: [
                                    ListTile(
                                      title: const Text('Tema'),
                                      trailing: RollingSwitch.icon(
                                        initialState: store.isSwitched,
                                        animationDuration:
                                            const Duration(milliseconds: 600),
                                        onChanged: (bool state) {
                                          setState(() {
                                            AppWidget.of(context)!.changeTheme(
                                                state
                                                    ? ThemeMode.dark
                                                    : ThemeMode.light);
                                            store.changeSwitch(state);
                                          });
                                        },
                                        rollingInfoRight: const RollingIconInfo(
                                          backgroundColor: Colors.deepPurple,
                                          icon: Icons.nights_stay,
                                          text: Text(
                                            'Dark',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        rollingInfoLeft: const RollingIconInfo(
                                          backgroundColor: Colors.amber,
                                          icon: Icons.wb_sunny,
                                          text: Text(
                                            'Light',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ListTile(
                                        title: const Text('Logout'),
                                        trailing: ElevatedButton.icon(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.deepPurple),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                side: const BorderSide(
                                                  color: Colors.deepPurple,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.logout,
                                            color: Colors.white,
                                          ),
                                          label: const Padding(
                                            padding: EdgeInsets.all(14.0),
                                            child: Text(
                                              'Sair',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          store.logoff();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  children: [
                                    Card(
                                      color: Colors.grey,
                                      elevation: 4,
                                      child: ListTile(
                                        title: const Text(
                                          'CORES',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 48,
                                          ),
                                          onTap: () {
                                            store.novaCor();
                                          },
                                        ),
                                      ),
                                    ),
                                    Observer(builder: (_) {
                                      return store.settings.color == null
                                          ? const Center(
                                              child: SizedBox(
                                                  child:
                                                      CircularProgressIndicator()))
                                          : ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              controller: ScrollController(),
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.all(4),
                                              itemCount:
                                                  store.settings.color!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var linha = store
                                                    .settings.color![index];
                                                return Wrap(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        ConvertIcon()
                                                            .convertColorName(
                                                                linha),
                                                        style: TextStyle(
                                                          color: ConvertIcon()
                                                              .convertColor(
                                                                  linha),
                                                        ),
                                                      ),
                                                      trailing: GestureDetector(
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                        onTap: () {
                                                          store.deleteColor(
                                                              linha);
                                                        },
                                                      ),
                                                    ),
                                                    const Divider(),
                                                  ],
                                                );
                                              });
                                    }),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }
}
