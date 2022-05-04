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
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.all(0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.94,
        height: widget.constraint > LarguraLayoutBuilder().telaPc
            ? MediaQuery.of(context).size.height * 0.085
            : MediaQuery.of(context).size.height * 0.045,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              store.client.theme
                  ? darkThemeData(context).iconTheme.color
                  : lightThemeData(context).iconTheme.color,
            ),
          ),
          onPressed: () {
            store.clientCreate.setSubtarefaTextSave(widget.texto.text);
            store.clientCreate.isValidSubtarefa
                ? store.clientCreate.setSubtarefas()
                : DialogButtom().showDialog(
                    ErrorsWidget(
                      tarefa: false,
                      theme: store.client.theme,
                    ),
                    store.client.theme,
                    widget.constraint,
                    context,
                  );
            store.clientCreate.setSubtarefaTextSave('');
            widget.texto.text = '';
            FocusScope.of(context).unfocus();
          },
          icon: const Icon(Icons.add_circle, size: 18),
          label: store.clientCreate.loadingSubtarefa
              ? const CircularProgressWidget()
              : Text(
                  store.clientCreate.editar ? 'EDITAR' : "INCLUIR",
                ),
        ),
      ),
    );
  }
}
