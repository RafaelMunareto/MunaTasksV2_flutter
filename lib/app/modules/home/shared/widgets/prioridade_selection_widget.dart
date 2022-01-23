import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/shared/model/prioridade_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class PrioridadeSelectionWidget extends StatefulWidget {
  final dynamic prioridadeList;
  final Function setPrioridadeSelection;
  final int prioridadeSelection;
  final TarefaModel tarefaModel;
  final Function changePrioridadeList;
  const PrioridadeSelectionWidget({
    Key? key,
    required this.prioridadeList,
    required this.setPrioridadeSelection,
    required this.prioridadeSelection,
    required this.tarefaModel,
    required this.changePrioridadeList,
  }) : super(key: key);

  @override
  State<PrioridadeSelectionWidget> createState() =>
      _PrioridadeSelectionWidgetState();
}

class _PrioridadeSelectionWidgetState extends State<PrioridadeSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Observer(
        builder: (_) {
          if (widget.prioridadeList!.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<PrioridadeModel> list = widget.prioridadeList!.data;
            return Wrap(
              runAlignment: WrapAlignment.spaceAround,
              spacing: 16,
              children: [
                for (var index = 0; index < list.length; index++)
                  InputChip(
                    key: ObjectKey(list[index].reference),
                    labelPadding: const EdgeInsets.all(2),
                    elevation: 4.0,
                    avatar: list[index].prioridade == 4
                        ? const Icon(Icons.all_inbox, color: Colors.grey)
                        : Icon(
                            Icons.flag,
                            color: ConvertIcon()
                                .convertColorFlaf(list[index].prioridade),
                          ),
                    label: SizedBox(
                      child: Text(
                        list[index].prioridade == 4
                            ? 'Normal'
                            : 'Prioridade ' + list[index].prioridade.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.setPrioridadeSelection(list[index].prioridade);
                        widget.changePrioridadeList(widget.tarefaModel);
                        Modular.to.pop();
                      });
                    },
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}