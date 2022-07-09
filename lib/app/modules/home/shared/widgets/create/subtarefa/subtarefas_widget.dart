import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:getwidget/getwidget.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/list_subtarefa_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class SubtarefasWidget extends StatefulWidget {
  final TextEditingController controller;
  const SubtarefasWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<SubtarefasWidget> createState() => _SubtarefasWidgetState();
}

class _SubtarefasWidgetState extends State<SubtarefasWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: store.client.theme
                ? darkThemeData(context).scaffoldBackgroundColor
                : lightThemeData(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: ListSubtarefaWidget(
                    tipo: 'pause',
                    controller: widget.controller,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ListSubtarefaWidget(
                    tipo: 'play',
                    controller: widget.controller,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ListSubtarefaWidget(
                    tipo: 'check',
                    controller: widget.controller,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: 120,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
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
                                      minWidth: 95, minHeight: 50),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              minWidth: 90, minHeight: 20),
                                          child: Card(
                                              color:
                                                  Colors.blue.withOpacity(0.5),
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
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (totais.id == 'todos') {
                                                      store.getDio();
                                                    } else {
                                                      store.client
                                                          .setUserSelection(
                                                              totais.name);
                                                      store
                                                          .changeFilterUserList();
                                                      store.client.setImgUrl(
                                                          totais.name.urlImage);
                                                    }
                                                  },
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors
                                                        .click,
                                                    child: GFAvatar(
                                                      radius: 18,
                                                      shape: GFAvatarShape
                                                          .standard,
                                                      backgroundImage:
                                                          NetworkImage(totais
                                                              .name!.urlImage),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            totais.qtdSubtarefas > 0
                                                ? Tooltip(
                                                    message:
                                                        "Qtd de Subtarefas",
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Badge(
                                                        toAnimate: false,
                                                        badgeColor: Colors
                                                            .grey.shade300,
                                                        badgeContent: Text(
                                                            totais.qtdSubtarefas >
                                                                    1
                                                                ? totais
                                                                    .qtdSubtarefas
                                                                    .toString()
                                                                : totais
                                                                    .qtdSubtarefas
                                                                    .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14)),
                                                      ),
                                                    ),
                                                  )
                                                : Tooltip(
                                                    message:
                                                        "Qtd de Subtarefas",
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Badge(
                                                        toAnimate: false,
                                                        badgeColor: Colors.red,
                                                        badgeContent:
                                                            const Text('0',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
