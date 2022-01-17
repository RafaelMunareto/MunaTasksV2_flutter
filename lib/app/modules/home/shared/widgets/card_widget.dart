import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_text_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/button_action_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/header_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class CardWidget extends StatefulWidget {
  final List<TarefaModel> tarefa;
  final Function deleteTasks;
  final int navigateBarSelection;
  final int navigate;
  final Function save;
  final bool theme;
  final Animation<double> opacidade;
  const CardWidget(
      {Key? key,
      required this.tarefa,
      required this.deleteTasks,
      required this.navigateBarSelection,
      required this.navigate,
      required this.opacidade,
      required this.theme,
      required this.save})
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
    card(linha) {
      return Card(
        shape: Border(
          right: BorderSide(
              color: ConvertIcon().convertColor(linha.etiqueta.color),
              width: 5),
        ),
        elevation: 8,
        key: ValueKey(linha),
        child: ExpansionTile(
          key: UniqueKey(),
          textColor: Colors.black,
          title: HeaderWidget(tarefa: linha, theme: widget.theme),
          subtitle: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Wrap(
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
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              linha.data.seconds * 1000))
                          .toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: widget.theme ? Colors.white : Colors.black),
                    ),
                  ],
                ),
                Icon(
                  Icons.flag,
                  color: ConvertIcon().convertColorFlaf(linha.prioridade),
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

  changeIconeAndColorTime(data) {
    DateTime now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(data.seconds * 1000);
    if (date.isAfter(now)) {
      return [Colors.blue, Icons.timelapse_sharp];
    } else if (date == now) {
      return [Colors.amber, Icons.alarm];
    } else {
      return [Colors.red, Icons.history];
    }
  }
}
