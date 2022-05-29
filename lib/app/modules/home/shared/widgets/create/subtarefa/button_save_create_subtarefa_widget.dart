import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
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
      padding: widget.constraint > LarguraLayoutBuilder().telaPc
          ? const EdgeInsets.all(4.0)
          : const EdgeInsets.all(0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.94,
        height: widget.constraint > LarguraLayoutBuilder().telaPc
            ? MediaQuery.of(context).size.height * 0.055
            : MediaQuery.of(context).size.height * 0.045,
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
                  tarefa: false,
                  theme: store.client.theme,
                ),
                store.client.theme,
                widget.constraint,
                context,
              );
            }
            FocusScope.of(context).unfocus();
          },
          icon: const Icon(Icons.add_circle, size: 16),
          label: store.clientCreate.loadingSubtarefa
              ? const CircularProgressWidget()
              : Text(
                  store.clientCreate.editar
                      ? 'EDITAR SUBTAREFA'
                      : "INCLUIR SUBTAREFA",
                ),
        ),
      ),
    );
  }
}
