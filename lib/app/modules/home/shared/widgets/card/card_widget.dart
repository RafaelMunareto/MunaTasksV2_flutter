import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card/body_card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/utils/functions_utils.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/create_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class CardWidget extends StatefulWidget {
  final TarefaDioModel tarefaDioModel;
  final double constraint;
  const CardWidget({
    Key? key,
    required this.tarefaDioModel,
    required this.constraint,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final HomeStore store = Modular.get();

  calc() {
    if (widget.tarefaDioModel.subTarefa!.isEmpty) {
      return 0;
    }
    return (widget.tarefaDioModel.subTarefa!
            .where((element) => element.status == 'check')
            .length /
        widget.tarefaDioModel.subTarefa!.length);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        await store.clientCreate.setLoadingSubtarefa(true);
        await store.clientCreate.setTarefaUpdate(
          widget.tarefaDioModel,
        );
        await store.clientCreate.cleanSubtarefa();
        await DialogButtom().showDialogCreate(const CreateWidget(),
            widget.constraint, context, store.changeFilterUserList);
        store.clientCreate.setLoadingSubtarefa(false);
      },
      onLongPress: () =>
          FunctionsUtils().dialogDelete(context, widget.tarefaDioModel, store),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: PhysicalModel(
          color: Colors.transparent,
          child: Card(
            key: UniqueKey(),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                      ),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Text(
                              widget.tarefaDioModel.etiqueta.etiqueta,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ConvertIcon().convertColor(
                                    widget.tarefaDioModel.etiqueta.color),
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 100,
                        maxHeight: double.infinity,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BodyCardWidget(
                            constraints: widget.constraint,
                            tarefa: widget.tarefaDioModel,
                            theme: store.client.theme,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '   ' + widget.tarefaDioModel.texto,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: store.client.theme
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                          widget.tarefaDioModel.subTarefa!.isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        key: UniqueKey(),
                                        minHeight: 2,
                                        backgroundColor: store.client.theme
                                            ? darkThemeData(context)
                                                .scaffoldBackgroundColor
                                            : lightThemeData(context)
                                                .scaffoldBackgroundColor,
                                        color: ConvertIcon().convertColor(widget
                                            .tarefaDioModel.etiqueta.color),
                                        value: calc(),
                                      ),
                                    ),
                                    Tooltip(
                                      message:
                                          "Qtd de Subtarefas feitas sobre o o total.",
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, right: 4),
                                        child: Text(
                                          '${widget.tarefaDioModel.subTarefa!.where((element) => element.status == 'check').length}/${widget.tarefaDioModel.subTarefa!.length}',
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    )
                                  ],
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
      ),
    );
  }
}
