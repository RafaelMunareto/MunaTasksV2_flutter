import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class ButtonSaveCreateSubtarefaWidget extends StatefulWidget {
  final double constraint;
  final TextEditingController texto;
  const ButtonSaveCreateSubtarefaWidget({
    Key? key,
    required this.constraint,
    required this.texto,
  }) : super(key: key);

  @override
  State<ButtonSaveCreateSubtarefaWidget> createState() =>
      _ButtonSaveCreateSubtarefaWidgetState();
}

class _ButtonSaveCreateSubtarefaWidgetState
    extends State<ButtonSaveCreateSubtarefaWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              store.client.theme
                  ? darkThemeData(context).primaryColor
                  : lightThemeData(context).primaryColor,
            ),
          ),
          onPressed: () {
            if (!store.clientCreate.editar) {
              store.clientCreate.setSubtarefaId(
                  DateTime.now().millisecondsSinceEpoch.toString());
            }
            store.clientCreate.setSubtarefaTextSave(widget.texto.text);
            if (store.clientCreate.isValidSubtarefa) {
              store.clientCreate.setSubtarefas();
              store.clientCreate.setSubtarefaTextSave('');
              widget.texto.text = '';
            } else {
              DialogButtom().showDialog(
                ErrorsWidget(
                  constraint: widget.constraint,
                  tarefa: false,
                  theme: store.client.theme,
                  erro: '',
                ),
                store.client.theme,
                widget.constraint,
                context,
              );
            }
            FocusScope.of(context).unfocus();
          },
          icon: const Icon(Icons.add_circle, size: 24),
          label: store.clientCreate.loadingSubtarefa
              ? const CircularProgressWidget()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    store.clientCreate.editar
                        ? 'EDITAR SUBTAREFA'
                        : "INCLUIR SUBTAREFA",
                  ),
                ),
        ),
      ),
    );
  }
}
