import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:rolling_switch/rolling_switch.dart';

import '../../../app_widget.dart';

class PrincipalPage extends StatefulWidget {
  final String title;
  const PrincipalPage({Key? key, this.title = 'Configurações'})
      : super(key: key);
  @override
  PrincipalPageState createState() => PrincipalPageState();
}

class PrincipalPageState extends State<PrincipalPage>
    with SingleTickerProviderStateMixin {
  final PrincipalStore store = Modular.get();
  late Animation<double> opacidade;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _popMenu() {
      return PopupMenuButton(
        icon: Observer(
          builder: (_) {
            return ListTile(
              leading: Text(
                store.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
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
            );
          },
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
            child: ListTile(
              onTap: () {
                store.setLabel('Order');
                store.setEscolha(store.settings.order);
                Navigator.pop(context);
              },
              leading: const Text(
                "Order",
              ),
              trailing: const Icon(Icons.sort),
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              onTap: () {
                store.setLabel('Color');
                store.setEscolha(store.settings.color);
                Navigator.pop(context);
              },
              leading: const Text("Color"),
              trailing: const Icon(Icons.color_lens_outlined),
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              onTap: () {
                store.setLabel('Subtarefa');
                store.setEscolha(store.settings.subtarefaInsert);
                Navigator.pop(context);
              },
              leading: const Text("Subtarefa"),
              trailing: const Icon(Icons.task),
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              onTap: () {
                store.setLabel('Prioridade');
                store.setEscolha(store.settings.prioridade);
                Navigator.pop(context);
              },
              leading: const Text("Prioridade"),
              trailing: const Icon(Icons.numbers),
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              onTap: () {
                store.setLabel('Tempo');
                store.setEscolha(store.settings.retard);
                Navigator.pop(context);
              },
              leading: const Text("Tempo"),
              trailing: const Icon(Icons.timelapse_rounded),
            ),
          ),
        ],
      );
    }

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
                                  shrinkWrap: true,
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
                                flex: 1,
                                child: Card(
                                  color: Colors.deepPurple,
                                  elevation: 4,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: _popMenu(),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  children: [
                                    Observer(builder: (_) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            controller: ScrollController(),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(4),
                                            itemCount: store.escolha.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var linha = store.escolha[index];
                                              return Wrap(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      store.label == 'Tempo'
                                                          ? linha['tempoName']
                                                              .toString()
                                                              .toUpperCase()
                                                          : linha
                                                              .toString()
                                                              .toUpperCase(),
                                                    ),
                                                    trailing: GestureDetector(
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      onTap: () {
                                                        store.deleteColor(
                                                          linha,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const Divider(),
                                                ],
                                              );
                                            }),
                                      );
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
