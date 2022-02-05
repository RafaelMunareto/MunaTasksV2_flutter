import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/prioridade_selection_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class PrioridadeSaveWidget extends StatefulWidget {
  final String title;
  const PrioridadeSaveWidget({Key? key, this.title = "PrioridadeSaveWidget"})
      : super(key: key);

  @override
  State<PrioridadeSaveWidget> createState() => _PrioridadeSaveWidgetState();
}

class _PrioridadeSaveWidgetState extends State<PrioridadeSaveWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    prioridade() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Prioridade'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: PrioridadeSelectionWidget(
                create: true,
                prioridadeSelection: store.clientCreate.tarefaModelPrioritario,
                prioridadeList: store.client.prioridadeList,
                setPrioridadeSelection:
                    store.clientCreate.setPrioridadeSaveSelection,
              ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () => prioridade(),
      child: Observer(
        builder: (_) {
          return Padding(
            key: UniqueKey(),
            padding: const EdgeInsets.fromLTRB(0, 12, 24, 12),
            child: Icon(
              store.clientCreate.tarefaModelPrioritario == 0
                  ? Icons.flag_outlined
                  : Icons.flag,
              color: ConvertIcon().convertColorFlaf(
                store.clientCreate.tarefaModelPrioritario,
              ),
            ),
          );
        },
      ),
    );
  }
}
