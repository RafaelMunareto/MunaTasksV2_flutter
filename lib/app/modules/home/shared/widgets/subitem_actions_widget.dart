import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class SubitemActionsWidget extends StatefulWidget {
  final List<String> subtarefaActionList;
  final Function setSubtarefaAction;
  final SubtarefaModel subtarefaModel;
  final TarefaModel tarefaModel;
  final Function changeSubtarefaModelAction;
  const SubitemActionsWidget({
    Key? key,
    required this.subtarefaActionList,
    required this.setSubtarefaAction,
    required this.subtarefaModel,
    required this.tarefaModel,
    required this.changeSubtarefaModelAction,
  }) : super(key: key);

  @override
  State<SubitemActionsWidget> createState() => _SubitemActionsWidgetState();
}

class _SubitemActionsWidgetState extends State<SubitemActionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var linha in widget.subtarefaActionList)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputChip(
              key: ObjectKey(linha.toString()),
              labelPadding: const EdgeInsets.all(2),
              elevation: 4.0,
              avatar: Icon(ConvertIcon().iconStatus(linha),
                  color: ConvertIcon().iconStatusColor(linha)),
              label: SizedBox(
                child: Text(
                  ConvertIcon().labelStatus(linha),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.setSubtarefaAction(linha);
                  widget.changeSubtarefaModelAction(
                      widget.subtarefaModel, widget.tarefaModel);
                  Modular.to.pop();
                });
              },
            ),
          ),
      ],
    );
  }
}
