import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/sub_item_widget.dart';

class BodyTextWidget extends StatelessWidget {
  final TarefaModel tarefa;
  final bool theme;
  final Function changeSubtarefaModelAction;
  final Function setSubtarefaModel;
  final List<String> subtarefaActionList;
  const BodyTextWidget(
      {Key? key,
      required this.tarefa,
      required this.theme,
      required this.changeSubtarefaModelAction,
      required this.setSubtarefaModel,
      required this.subtarefaActionList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var i = 0; i < tarefa.subTarefa!.length; i++)
          SubItemWidget(
            subTarefa: tarefa.subTarefa![i],
            changeSubtarefaModelAction: changeSubtarefaModelAction,
            setSubtarefaModel: setSubtarefaModel,
            subtarefaActionList: subtarefaActionList,
            tarefaModel: tarefa,
            theme: theme,
          ),
      ],
    );
  }
}
