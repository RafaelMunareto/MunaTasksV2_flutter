import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_text_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/button_action_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/header_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/prioridade_selection_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/retard_action_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class CardWidget extends StatefulWidget {
  final Animation<double> opacidade;
  final AnimationController controller;

  const CardWidget({
    Key? key,
    required this.opacidade,
    required this.controller,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final HomeStore store = Modular.get();
  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = store.client.tarefas.removeAt(oldindex);
      store.client.tarefas.insert(newindex, items);
    });
  }

  @override
  Widget build(BuildContext context) {
    dialogDelete(String message, TarefaModel tarefa, context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Tem certeza que deseja excluir?'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Modular.to.pop();
                  SnackbarCustom()
                      .createSnackBar('Cancelado', Colors.grey, context);
                },
                child: const Text('CANCELAR'),
              ),
              TextButton(
                onPressed: () {
                  Modular.to.pop();
                  store.deleteTasks(tarefa);
                  SnackbarCustom().createSnackBar(
                      'Deletado com sucesso!', Colors.green, context);
                },
                child: const Text('DELETAR'),
              ),
            ],
          );
        },
      );
    }

    _retard(TarefaModel model) {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adiamento'),
            content: RetardActionWidget(
              retard: store.client.retardList,
              retardSelection: store.client.retardSelection,
              setRetardSelection: store.client.setRetardSelection,
              updateDate: store.updateDate,
              model: model,
            ),
          );
        },
      );
    }

    prioridade(tarefaModel) {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Prioridade'),
            content: PrioridadeSelectionWidget(
              prioridadeSelection: store.client.prioridadeSelection,
              prioridadeList: store.client.prioridadeList,
              setPrioridadeSelection: store.client.setPrioridadeSelection,
              tarefaModel: tarefaModel,
              changePrioridadeList: store.changePrioridadeList,
            ),
          );
        },
      );
    }

    card(linha) {
      return PhysicalModel(
        key: UniqueKey(),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: PhysicalModel(
            color: Colors.transparent,
            elevation: 8,
            child: Card(
              shape: Border(
                right: BorderSide(
                    color: ConvertIcon().convertColor(linha.etiqueta.color),
                    width: 5),
              ),
              child: ExpansionTile(
                key: UniqueKey(),
                textColor: Colors.black,
                title: HeaderWidget(tarefa: linha, theme: store.client.theme),
                subtitle: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _retard(linha),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                changeIconeAndColorTime(linha.data)[1],
                                color: changeIconeAndColorTime(linha.data)[0],
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(linha.data)
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
                        onTap: () => prioridade(linha),
                        child: Icon(
                          Icons.flag,
                          color:
                              ConvertIcon().convertColorFlaf(linha.prioridade),
                        ),
                      )
                    ],
                  ),
                ),
                children: [
                  Wrap(
                    children: [
                      BodyTextWidget(
                        tarefa: linha,
                        theme: store.client.theme,
                        changeSubtarefaModelAction: store.changeSubtarefaAction,
                        setSubtarefaModel: store.client.setSubtarefaModel,
                        subtarefaActionList: store.client.subtarefaActionList,
                      ),
                      ButtonActionWidget(
                        tarefa: linha,
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
      );
    }

    return Observer(builder: (_) {
      return FadeTransition(
        opacity: widget.opacidade,
        child: ReorderableListView(
          onReorder: reorderData,
          children: [
            for (var linha in store.client.tarefas)
              Dismissible(
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.green,
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
                    color: Colors.red,
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
                    setState(() {
                      store.clientCreate.setTarefaUpdate(linha);
                      store.client.setExpand(!store.client.expand);
                      widget.controller.forward();
                    });
                  } else {
                    setState(() {
                      dialogDelete(linha.texto, linha, context);
                    });
                  }
                },
                child: card(linha),
              ),
          ],
        ),
      );
    });
  }

  changeIconeAndColorTime(date) {
    DateTime now = DateTime.now();
    if (date.isAfter(now)) {
      return [Colors.blue, Icons.timelapse_sharp];
    } else if (date == now) {
      return [Colors.amber, Icons.alarm];
    } else {
      return [Colors.red, Icons.history];
    }
  }
}
