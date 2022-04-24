import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/prioridade_selection_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

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
    return LayoutBuilder(builder: (context, constraint) {
      return GestureDetector(
        onTap: () => DialogButtom().showDialog(
          PrioridadeSelectionWidget(
            create: true,
            prioridadeSelection: store.clientCreate.tarefaModelPrioritario,
            setPrioridadeSelection:
                store.clientCreate.setPrioridadeSaveSelection,
          ),
          store.client.theme,
          constraint.maxWidth,
          context,
        ),
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
    });
  }
}
