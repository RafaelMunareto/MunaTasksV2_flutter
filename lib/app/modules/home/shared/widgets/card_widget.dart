import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_text_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/button_action_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/header_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class CardWidget extends StatefulWidget {
  final List<TarefaModel> tarefa;
  final Function deleteTasks;
  final int navigate;
  final Function save;
  const CardWidget(
      {Key? key,
      required this.tarefa,
      required this.deleteTasks,
      required this.navigate,
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
    return ReorderableListView(
      onReorder: reorderData,
      children: [
        for (var linha in widget.tarefa)
          Card(
            shape: const Border(
              right: BorderSide(color: Colors.red, width: 5),
            ),
            elevation: 8,
            key: ValueKey(linha),
            child: ExpansionTile(
              backgroundColor: const Color(0xff719CFF),
              textColor: Colors.black,
              title: HeaderWidget(
                tarefa: linha,
              ),
              subtitle: Align(
                alignment: Alignment.topLeft,
                child: Row(
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
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              children: [
                Wrap(
                  children: [
                    BodyTextWidget(
                      tarefa: linha,
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
      ],
    );
  }

  changeIconeAndColorTime(data) {
    DateTime now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(data.seconds * 1000);
    if (date.isBefore(now)) {
      return [Colors.blue, Icons.timelapse_sharp];
    } else if (date == now) {
      return [Colors.amber, Icons.alarm];
    } else {
      return [Colors.red, Icons.history];
    }
  }
}
