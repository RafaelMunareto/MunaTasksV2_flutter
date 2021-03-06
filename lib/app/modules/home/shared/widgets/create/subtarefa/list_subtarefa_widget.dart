import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/simple_button_widget.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class ListSubtarefaWidget extends StatefulWidget {
  final String tipo;
  final TextEditingController controller;
  const ListSubtarefaWidget(
      {Key? key, required this.tipo, required this.controller})
      : super(key: key);

  @override
  State<ListSubtarefaWidget> createState() => _ListSubtarefaWidgetState();
}

class _ListSubtarefaWidgetState extends State<ListSubtarefaWidget> {
  HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: ConvertIcon().colorStatus(widget.tipo),
                          width: 15),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              ConvertIcon().nameStatus(widget.tipo),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Badge(
                              toAnimate: false,
                              shape: BadgeShape.square,
                              badgeColor:
                                  ConvertIcon().colorStatusDark(widget.tipo),
                              borderRadius: BorderRadius.circular(8),
                              badgeContent: Text(
                                  store.clientCreate.subtarefas
                                      .where((element) =>
                                          element.status == widget.tipo)
                                      .length
                                      .toString(),
                                  style: const TextStyle(color: Colors.white)),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.80,
            child: ReorderableListView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                scrollController: ScrollController(),
                padding: const EdgeInsets.all(4),
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final dynamic item =
                        store.clientCreate.subtarefasFilter.removeAt(oldIndex);
                    store.clientCreate.subtarefasFilter.insert(newIndex, item);
                  });
                },
                itemCount: store.clientCreate.subtarefasFilter
                    .where((element) => element.status == widget.tipo)
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  var linha = store.clientCreate.subtarefasFilter
                      .where((element) => element.status == widget.tipo)
                      .toList()[index];
                  return GestureDetector(
                    key: ValueKey(linha.id),
                    onTap: () {
                      store.clientCreate.setEditarSubtarefa(true);
                      store.clientCreate.setEditar(true);
                      store.clientCreate.setSubtarefaUpdate(linha);
                      store.clientCreate
                          .setSubtarefasUpdate(store.clientCreate.subtarefas);

                      widget.controller.text = linha.texto;
                    },
                    onDoubleTap: () {
                      dialogDelete(context, linha);
                    },
                    child: linha == null
                        ? Container()
                        : MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Card(
                              elevation: 2,
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color: ConvertIcon()
                                              .colorStatusDark(widget.tipo),
                                          width: 5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 14,
                                          child: RotatedBox(
                                            quarterTurns: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4, left: 4),
                                              child: Center(
                                                child: AutoSizeText(
                                                  linha.title,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CircleAvatarWidget(
                                                        nameUser: linha
                                                            .user.name.name,
                                                        url: linha
                                                            .user.urlImage),
                                                  ],
                                                ),
                                              ),
                                              ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 100,
                                                  maxHeight: double.infinity,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(16, 8, 22, 8),
                                                    child: Text(
                                                      '   ' + linha.texto,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
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
                }),
          )
        ],
      );
    });
  }

  dialogDelete(context, tarefa) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 200,
          height: 200,
          child: AlertDialog(
            key: Key(tarefa.id!),
            title: Text(
              'Excluir Tarefa',
              style: TextStyle(
                  color: store.client.theme
                      ? darkThemeData(context).primaryColor
                      : lightThemeData(context).primaryColor),
            ),
            content: const Text(
              'Tem certeza que deseja exclu??r a tarefa ?',
              maxLines: 1,
            ),
            actions: [
              SimpleButtonWidget(
                theme: store.client.theme,
                buttonName: 'CANCELAR',
                popUp: true,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    store.client.theme
                        ? darkThemeData(context).primaryColor
                        : lightThemeData(context).primaryColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                        color: store.client.theme
                            ? darkThemeData(context).primaryColorLight
                            : lightThemeData(context).primaryColorLight,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  store.clientCreate.subtarefas
                      .removeWhere((element) => element.id == tarefa.id);
                  store.clientCreate.cleanSubtarefa();
                  store.clientCreate.setTarefa();
                  store.updateNewTarefa(store.clientCreate.tarefaModelSave);
                  widget.controller.text = '';
                  SnackbarCustom().createSnackBar(
                      'Deletado com sucesso!', Colors.green, context);
                  Modular.to.pop();
                  store.clientCreate.subtarefasVsPerfil();
                },
                child: Text(
                  'DELETAR',
                  style: TextStyle(
                    color: store.client.theme
                        ? darkThemeData(context).scaffoldBackgroundColor
                        : lightThemeData(context).scaffoldBackgroundColor,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
