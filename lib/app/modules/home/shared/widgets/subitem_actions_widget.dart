import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class SubitemActionsWidget extends StatefulWidget {
  final SubtareDiofaModel subtarefaModel;
  final TarefaDioModel tarefaModel;
  const SubitemActionsWidget({
    Key? key,
    required this.subtarefaModel,
    required this.tarefaModel,
  }) : super(key: key);

  @override
  State<SubitemActionsWidget> createState() => _SubitemActionsWidgetState();
}

class _SubitemActionsWidgetState extends State<SubitemActionsWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Wrap(
            children: [
              for (var linha in store.client.subtarefaActionList)
                Padding(
                  padding: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                      ? const EdgeInsets.all(8)
                      : const EdgeInsets.only(bottom: 4.0),
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
                      store.client.setSubtarefaAction(linha);
                      store.changeSubtarefaDioAction(
                        widget.subtarefaModel,
                        widget.tarefaModel,
                      );
                      Modular.to.pop();
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
