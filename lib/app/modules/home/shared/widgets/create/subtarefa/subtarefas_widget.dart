import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:getwidget/getwidget.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefas_qtd_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/layoutCreate/layout_create_subtarefas_widget%20.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/list_subtarefa_widget.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
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
  List<SubtarefasQtdModel> totais = [];
  List<dynamic> subtarefasTotal = [];
  @override
  void initState() {
    setState(() {
      subtarefasTotal = store.clientCreate.subtarefas;
    });
    subtarefasVsPerfil();
    super.initState();
  }

  subtarefasVsPerfil() async {
    totais.add(SubtarefasQtdModel.fromDocument({
      "name": 'TODOS',
      "urlImage": DioStruture().baseUrlMunatasks + 'files/todos.png',
      "qtdSubtarefa": store.clientCreate.subtarefas.length
    }));
    for (var e in store.clientCreate.subtarefas) {
      if (totais.where((element) => element.name == e.user.name.name).isEmpty) {
        totais.add(SubtarefasQtdModel.fromDocument({
          "name": e.user.name.name,
          "urlImage": e.user.urlImage,
          "qtdSubtarefa": calculaQtdSubtarefa(e.user.id)
        }));
      }
    }
  }

  calculaQtdSubtarefa(String id) {
    return store.clientCreate.subtarefas
        .where((element) => element.user.id == id)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Observer(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: store.client.theme
                  ? darkThemeData(context).scaffoldBackgroundColor
                  : lightThemeData(context).scaffoldBackgroundColor,
              child: LayoutCreateSubtarefasWidget(
                constraint: constraint.maxWidth,
                widget1: ListSubtarefaWidget(
                  tipo: 'pause',
                  controller: widget.controller,
                ),
                widget2: ListSubtarefaWidget(
                  tipo: 'play',
                  controller: widget.controller,
                ),
                widget3: ListSubtarefaWidget(
                  tipo: 'check',
                  controller: widget.controller,
                ),
                widget4: Padding(
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
                          for (var linha in totais)
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: 95, minHeight: 50),
                                child: GestureDetector(
                                  onTap: () {
                                    if (linha.name == 'TODOS') {
                                      store.clientCreate
                                          .setSubtarefasSearch(subtarefasTotal);
                                    } else {
                                      store.clientCreate
                                          .setSubtarefasSearch(subtarefasTotal);
                                      store.clientCreate.setSubtarefasSearch(
                                          store.clientCreate.subtarefas = store
                                              .clientCreate.subtarefas
                                              .where((element) =>
                                                  element.user.name.name ==
                                                  linha.name)
                                              .toList());
                                    }
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: SizedBox(
                                      width: 110,
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          children: [
                                            ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  minWidth: 90, minHeight: 20),
                                              child: Card(
                                                  color: Colors.blue
                                                      .withOpacity(0.5),
                                                  child: Center(
                                                      child: Text(
                                                    linha.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 8,
                                                        color: kWhite),
                                                  ))),
                                            ),
                                            Wrap(
                                              alignment: WrapAlignment.center,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4, bottom: 4),
                                                  child: Tooltip(
                                                    message: linha.name,
                                                    child: GFAvatar(
                                                      radius: 18,
                                                      shape: GFAvatarShape
                                                          .standard,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              linha.urlImage),
                                                    ),
                                                  ),
                                                ),
                                                linha.qtdSubtarefa > 0
                                                    ? Tooltip(
                                                        message:
                                                            "Qtd de Subtarefas",
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Badge(
                                                            toAnimate: false,
                                                            badgeColor: Colors
                                                                .grey.shade300,
                                                            badgeContent: Text(
                                                                linha.qtdSubtarefa >
                                                                        1
                                                                    ? linha
                                                                        .qtdSubtarefa
                                                                        .toString()
                                                                    : linha
                                                                        .qtdSubtarefa
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
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Badge(
                                                            toAnimate: false,
                                                            badgeColor:
                                                                Colors.red,
                                                            badgeContent:
                                                                const Text('0',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                    )),
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
            ),
          );
        },
      );
    });
  }
}
