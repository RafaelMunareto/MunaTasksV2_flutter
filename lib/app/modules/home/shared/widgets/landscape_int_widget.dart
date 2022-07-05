import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

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
    final ScrollController scrollController = ScrollController();

    return Observer(builder: (_) {
      return store.client.loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 120,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (var totais in store.client.tarefasTotais)
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: 120, minHeight: 70),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  children: [
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          minWidth: 115, minHeight: 25),
                                      child: Card(
                                          color: Colors.blue.withOpacity(0.5),
                                          child: Center(
                                              child: Text(
                                            totais.name.name.name,
                                            style: const TextStyle(
                                                fontSize: 8, color: kWhite),
                                          ))),
                                    ),

                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 4, bottom: 4),
                                          child: Tooltip(
                                            message: totais.name!.name.name,
                                            child: GFAvatar(
                                              radius: 18,
                                              shape: GFAvatarShape.standard,
                                              backgroundImage: NetworkImage(
                                                  totais.name!.urlImage),
                                            ),
                                          ),
                                        ),
                                        totais.qtd > 0
                                            ? Tooltip(
                                                message: "Qtd de Tarefas",
                                                child: Badge(
                                                  toAnimate: false,
                                                  badgeColor:
                                                      Colors.grey.shade400,
                                                  badgeContent: Text(
                                                      totais.qtd > 1
                                                          ? totais.qtd
                                                              .toString()
                                                          : totais.qtd
                                                              .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 14)),
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
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Badge(
                                                    toAnimate: false,
                                                    badgeColor: Colors
                                                        .blueGrey.shade400,
                                                    badgeContent: Text(
                                                        totais.qtdSubtarefas > 1
                                                            ? totais
                                                                .qtdSubtarefas
                                                                .toString()
                                                            : totais
                                                                .qtdSubtarefas
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 9)),
                                                  ),
                                                ),
                                              )
                                            : Tooltip(
                                                message: "Qtd de Subtarefas",
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Badge(
                                                    toAnimate: false,
                                                    badgeColor: Colors.red,
                                                    badgeContent:
                                                        const Text('0',
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                            )),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                    // ),
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
    });
  }
}
