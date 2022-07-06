import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';

class TextSaveWidget extends StatefulWidget {
  final TextEditingController? controller;
  final TextEditingController? controllerSubtarefa;
  final bool subtarefa;
  const TextSaveWidget(
      {Key? key,
      this.controller,
      this.controllerSubtarefa,
      required this.subtarefa})
      : super(key: key);

  @override
  State<TextSaveWidget> createState() => _TextSaveWidgetState();
}

class _TextSaveWidgetState extends State<TextSaveWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    if (store.clientCreate.tarefaModelSaveTexto.isNotEmpty) {
      widget.controller!.text = store.clientCreate.tarefaModelSaveTexto;
    } else {
      widget.controller!.text = '';
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextFormField(
            autocorrect: true,
            autofocus: false,
            controller: widget.subtarefa
                ? widget.controllerSubtarefa
                : widget.controller,
            onChanged: (value) => widget.subtarefa
                ? store.clientCreate.setSubtarefaTextSave(value)
                : store.clientCreate.setTarefaTextSave(value),
            minLines: 6,
            maxLines: 20,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffix: InkWell(
                    child: const Icon(Icons.replay),
                    onTap: () {
                      if (widget.subtarefa) {
                        store.clientCreate.setSubtarefaTextSave('');
                        widget.controllerSubtarefa!.text = '';
                      } else {
                        store.clientCreate.setTarefaTextSave('');
                        widget.controller!.text = '';
                      }
                      FocusScope.of(context).requestFocus(FocusNode());
                    }),
                hintText: widget.subtarefa
                    ? "Insira sua subtarefa"
                    : "Insira sua tarefa"),
          ),
        ),
      ),
    );
  }
}
