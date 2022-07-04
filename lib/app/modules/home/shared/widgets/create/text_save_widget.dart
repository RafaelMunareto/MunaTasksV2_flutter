import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';

class TextSaveWidget extends StatefulWidget {
  final TextEditingController controller;
  const TextSaveWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TextSaveWidget> createState() => _TextSaveWidgetState();
}

class _TextSaveWidgetState extends State<TextSaveWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    setState(() {
      if (store.clientCreate.tarefaModelSaveTexto.isNotEmpty) {
        widget.controller.text = store.clientCreate.tarefaModelSaveTexto;
      } else {
        widget.controller.text = '';
      }
    });

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Center(
        child: SizedBox(
          width: 450,
          child: TextFormField(
            autocorrect: true,
            autofocus: false,
            controller: widget.controller,
            onChanged: (value) => store.clientCreate.setTarefaTextSave(value),
            minLines: 6,
            maxLines: 6,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffix: InkWell(
                    child: const Icon(Icons.replay),
                    onTap: () {
                      setState(() {
                        store.clientCreate.setTarefaTextSave('');
                        widget.controller.text = '';
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    }),
                hintText: "Insira sua tarefa"),
          ),
        ),
      ),
    );
  }
}
