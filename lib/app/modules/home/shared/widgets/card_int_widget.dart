import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_text_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/button_action_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/create_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/header_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/simple_button_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class CardIntWidget extends StatefulWidget {
  final TarefaDioModel tarefaDioModel;
  final double constraint;
  const CardIntWidget({
    Key? key,
    required this.tarefaDioModel,
    required this.constraint,
  }) : super(key: key);

  @override
  State<CardIntWidget> createState() => _CardIntWidgetState();
}

class _CardIntWidgetState extends State<CardIntWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        store.clientCreate.setTarefaUpdate(
          widget.tarefaDioModel,
        );
        store.clientCreate.cleanSubtarefa();
        DialogButtom().showDialogCreate(
            CreateWidget(
              constraint: widget.constraint,
            ),
            widget.constraint,
            context,
            store.changeFilterUserList);
      },
      child: Dismissible(
        background: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: const [
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  Text(
                    'Editar',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        secondaryBackground: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  Text(
                    'Excluir',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        key: UniqueKey(),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            store.clientCreate.setTarefaUpdate(
              widget.tarefaDioModel,
            );
            store.clientCreate.cleanSubtarefa();
            DialogButtom().showDialogCreate(
                CreateWidget(
                  constraint: widget.constraint,
                ),
                widget.constraint,
                context,
                store.changeFilterUserList);
          } else {
            dialogDelete(
              widget.tarefaDioModel.texto,
              widget.tarefaDioModel,
              context,
            );
          }
        },
        child: PhysicalModel(
          color: Colors.transparent,
          child: PhysicalModel(
            color: Colors.transparent,
            child: Card(
              key: UniqueKey(),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: ConvertIcon().convertColor(
                                widget.tarefaDioModel.etiqueta.color),
                            width: 15)),
                  ),
                  alignment: Alignment.centerLeft,
                  child: ExpansionTile(
                    textColor: Colors.black,
                    title: HeaderWidget(
                      tarefa: widget.tarefaDioModel,
                      theme: store.client.theme,
                    ),
                    subtitle: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => DialogButtom().showDialog(
                              retard(),
                              store.client.theme,
                              widget.constraint,
                              context,
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    changeIconeAndColorTime(
                                        widget.tarefaDioModel.data)[1],
                                    color: changeIconeAndColorTime(
                                        widget.tarefaDioModel.data)[0],
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(widget.tarefaDioModel.data)
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: store.client.theme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => DialogButtom().showDialog(
                              prioridade(),
                              store.client.theme,
                              widget.constraint,
                              context,
                            ),
                            child: Icon(
                              widget.tarefaDioModel.prioridade > 3
                                  ? Icons.flag_outlined
                                  : Icons.flag,
                              color: ConvertIcon().convertColorFlaf(
                                  widget.tarefaDioModel.prioridade),
                            ),
                          )
                        ],
                      ),
                    ),
                    children: [
                      Wrap(
                        children: [
                          BodyTextWidget(
                            tarefa: widget.tarefaDioModel,
                            theme: store.client.theme,
                            setSubtarefaModel: store.client.setSubtarefaModel,
                            subtarefaActionList:
                                store.client.subtarefaActionList,
                          ),
                          ButtonActionWidget(
                            constraint: widget.constraint,
                            tarefa: widget.tarefaDioModel,
                            navigate: store.client.navigateBarSelection,
                            save: store.save,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  changeIconeAndColorTime(date) {
    DateTime now = DateTime.now();
    if (date.isAfter(now)) {
      return [Colors.blue, Icons.timelapse_sharp];
    } else if (date.day == now.day) {
      return [Colors.amber, Icons.alarm];
    } else {
      return [Colors.red, Icons.history];
    }
  }

  dialogDelete(String message, TarefaDioModel tarefa, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 200,
          height: 200,
          child: AlertDialog(
            key: Key(tarefa.id!),
            title: Text(
              'Excluir Tarefa.',
              style: TextStyle(
                  color: store.client.theme
                      ? darkThemeData(context).primaryColor
                      : lightThemeData(context).primaryColor),
            ),
            content: const Text(
              'Tem certeza que deseja excluír a tarefa ?',
              maxLines: 1,
            ),
            actions: [
              SimpleButtonWidget(
                theme: store.client.theme,
                buttonName: 'CANCELAR',
                popUp: true,
              ),
              SimpleButtonWidget(
                theme: store.client.theme,
                buttonName: 'EXCLUIR',
                popUp: true,
                function: store.deleteDioTasks,
                dataFunction: tarefa,
                scnack: true,
                msgSnack: 'Deletado com sucesso!',
                delete: true,
                getFase: store.getDioFase(),
              ),
            ],
          ),
        );
      },
    );
  }

  retard() {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            runAlignment: WrapAlignment.spaceAround,
            spacing: 24,
            children: [
              for (var linha in store.client.retard)
                Padding(
                  padding:
                      widget.constraint > LarguraLayoutBuilder().larguraModal
                          ? const EdgeInsets.only(bottom: 16.0)
                          : const EdgeInsets.only(bottom: 16.0),
                  child: InputChip(
                    key: UniqueKey(),
                    labelPadding: const EdgeInsets.all(2),
                    elevation: 4.0,
                    avatar: const Icon(Icons.more_time_rounded),
                    label: SizedBox(
                      width: 100,
                      child: Text(
                        linha.tempoName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        store.client.setRetardSelection(linha.tempoValue);
                        Modular.to.pop();
                        FocusScope.of(context).requestFocus(FocusNode());
                        store.updateDate(widget.tarefaDioModel);
                        setState(() {
                          widget.tarefaDioModel.data = widget
                              .tarefaDioModel.data
                              .add(Duration(hours: linha.tempoValue));
                        });
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  prioridade() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            runAlignment: WrapAlignment.spaceAround,
            spacing: 24,
            children: [
              for (var linha in store.client.settings.prioridade ?? [])
                Padding(
                  padding:
                      widget.constraint > LarguraLayoutBuilder().larguraModal
                          ? const EdgeInsets.only(bottom: 16.0)
                          : const EdgeInsets.only(bottom: 16.0),
                  child: InputChip(
                    key: ObjectKey(linha),
                    labelPadding: const EdgeInsets.all(2),
                    elevation: 8.0,
                    avatar: linha == 4
                        ? const Icon(Icons.flag_outlined, color: Colors.grey)
                        : Icon(
                            Icons.flag,
                            color: ConvertIcon().convertColorFlaf(linha),
                          ),
                    label: SizedBox(
                      width: widget.constraint >= LarguraLayoutBuilder().telaPc
                          ? MediaQuery.of(context).size.width * 0.05
                          : MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        linha == 4
                            ? 'Normal'
                            : 'Prioridade ' + linha.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        store.client.setPrioridadeSelection(linha);
                        store.changePrioridadeList(widget.tarefaDioModel);
                        FocusScope.of(context).unfocus();
                        Modular.to.pop();
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
