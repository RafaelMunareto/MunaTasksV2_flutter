import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/sub_item_widget.dart';

class BodyTextWidget extends StatelessWidget {
  final TarefaDioModel tarefa;
  final bool theme;
  final Function setSubtarefaModel;
  final List<String> subtarefaActionList;
  const BodyTextWidget(
      {Key? key,
      required this.tarefa,
      required this.theme,
      required this.setSubtarefaModel,
      required this.subtarefaActionList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            tarefa.texto,
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: theme ? Colors.white : Colors.black),
          ),
        ),
        for (var i = 0; i < tarefa.subTarefa!.length; i++)
          SubItemWidget(
            subTarefa: tarefa.subTarefa![i],
            setSubtarefaModel: setSubtarefaModel,
            subtarefaActionList: subtarefaActionList,
            tarefaModel: tarefa,
            theme: theme,
          ),
      ],
    );
  }
}
