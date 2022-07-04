import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class LandscapeIntWidget extends StatefulWidget {
  final double constraint;
  final bool theme;
  const LandscapeIntWidget({
    Key? key,
    required this.constraint,
    required this.theme,
  }) : super(key: key);

  @override
  State<LandscapeIntWidget> createState() => _LandscapeIntWidgetState();
}

class _LandscapeIntWidgetState extends State<LandscapeIntWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();

    return Observer(builder: (_) {
      return store.client.loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 100,
                  child: SingleChildScrollView(
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (var totais in store.client.tarefasTotais)
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: Wrap(
                                  children: [
                                    CircleAvatarWidget(
                                      nameUser: totais.name.name.name,
                                      url: totais.name!.urlImage,
                                    ),
                                  ],
                                ),
                              ),
                              totais.qtd > 0
                                  ? Tooltip(
                                      message: "Qtd de Tarefas",
                                      child: Badge(
                                        toAnimate: false,
                                        badgeColor: Colors.grey.shade400,
                                        badgeContent: Text(
                                            totais.qtd > 1
                                                ? totais.qtd.toString()
                                                : totais.qtd.toString(),
                                            style:
                                                const TextStyle(fontSize: 14)),
                                      ),
                                    )
                                  : Tooltip(
                                      message: "Qtd de Tarefas",
                                      child: Badge(
                                        toAnimate: false,
                                        badgeColor: Colors.red,
                                        badgeContent: const Text('0',
                                            style: TextStyle(
                                              fontSize: 14,
                                            )),
                                      ),
                                    ),
                              totais.qtdSubtarefas > 0
                                  ? Tooltip(
                                      message: "Qtd de Subtarefas",
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Badge(
                                          toAnimate: false,
                                          badgeColor: Colors.blueGrey.shade400,
                                          badgeContent: Text(
                                              totais.qtdSubtarefas > 1
                                                  ? totais.qtdSubtarefas
                                                      .toString()
                                                  : totais.qtdSubtarefas
                                                      .toString(),
                                              style:
                                                  const TextStyle(fontSize: 9)),
                                        ),
                                      ),
                                    )
                                  : Tooltip(
                                      message: "Qtd de Subtarefas",
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Badge(
                                          toAnimate: false,
                                          badgeColor: Colors.red,
                                          badgeContent: const Text('0',
                                              style: TextStyle(
                                                fontSize: 9,
                                              )),
                                        ),
                                      ),
                                    ),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
