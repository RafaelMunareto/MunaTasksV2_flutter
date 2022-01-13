import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/sub_item_widget.dart';

class BodyTextWidget extends StatelessWidget {
  final TarefaModel tarefa;
  final bool theme;
  const BodyTextWidget({Key? key, required this.tarefa, required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var i = 0; i < tarefa.subTarefa!.length; i++)
          SubItemWidget(
            subTarefa: tarefa.subTarefa![i],
            theme: theme,
          ),
      ],
    );
  }
}
