import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_text_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/button_action_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/header_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/prioridade_selection_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/retard_action_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class CardWidget extends StatefulWidget {
  final List<TarefaModel> tarefa;
  final Function deleteTasks;
  final int navigateBarSelection;
  final int navigate;
  final Function save;
  final bool theme;
  final dynamic retard;
  final Animation<double> opacidade;
  final int retardSelection;
  final Function setRetardSelection;
  final Function updateDate;
  final dynamic prioridadeList;
  final Function changePrioridadeList;
  final Function setPrioridadeSelection;
  final int prioridadeSelection;
  final Function changeSubtarefaModelAction;
  final Function setSubtarefaModel;
  final List<String> subtarefaActionList;
  const CardWidget(
      {Key? key,
      required this.tarefa,
      required this.deleteTasks,
      required this.navigateBarSelection,
      required this.navigate,
      required this.opacidade,
      required this.theme,
      required this.retard,
      required this.retardSelection,
      required this.setRetardSelection,
      required this.save,
      required this.updateDate,
      required this.prioridadeList,
      required this.changePrioridadeList,
      required this.prioridadeSelection,
      required this.setPrioridadeSelection,
      required this.changeSubtarefaModelAction,
      required this.setSubtarefaModel,
      required this.subtarefaActionList})
      : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = widget.tarefa.removeAt(oldindex);
      widget.tarefa.insert(newindex, items);
    });
  }

  @override
  Widget build(BuildContext context) {
    _retard(TarefaModel model) {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adiamento'),
            content: RetardActionWidget(
              retard: widget.retard,
              retardSelection: widget.retardSelection,
              setRetardSelection: widget.setRetardSelection,
              updateDate: widget.updateDate,
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
              prioridadeSelection: widget.prioridadeSelection,
              prioridadeList: widget.prioridadeList,
              setPrioridadeSelection: widget.setPrioridadeSelection,
              tarefaModel: tarefaModel,
              changePrioridadeList: widget.changePrioridadeList,
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
                title: HeaderWidget(tarefa: linha, theme: widget.theme),
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
                                  color: widget.theme
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
                        theme: widget.theme,
                        changeSubtarefaModelAction:
                            widget.changeSubtarefaModelAction,
                        setSubtarefaModel: widget.setSubtarefaModel,
                        subtarefaActionList: widget.subtarefaActionList,
                      ),
                      ButtonActionWidget(
                          tarefa: linha,
                          deleteTasks: widget.deleteTasks,
                          navigate: widget.navigate,
                          save: widget.save),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return FadeTransition(
      opacity: widget.opacidade,
      child: ReorderableListView(
        onReorder: reorderData,
        children: [for (var linha in widget.tarefa) card(linha)],
      ),
    );
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
