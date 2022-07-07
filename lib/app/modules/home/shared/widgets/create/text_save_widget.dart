import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class TextSaveWidget extends StatefulWidget {
  final TextEditingController controller;
  const TextSaveWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<TextSaveWidget> createState() => _TextSaveWidgetState();
}

class _TextSaveWidgetState extends State<TextSaveWidget> {
  final HomeStore store = Modular.get();

  @override
  void initState() {
    if (store.clientCreate.tarefaModelSaveTexto != '') {
      widget.controller.text = store.clientCreate.tarefaModelSaveTexto;
    } else {
      widget.controller.text = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: TextFormField(
          autocorrect: true,
          autofocus: false,
          controller: widget.controller,
          onChanged: (value) => store.clientCreate.setTarefaTextSave(value),
          minLines: 10,
          maxLines: 15,
          decoration: InputDecoration(
              filled: true,
              fillColor: store.client.theme
                  ? darkThemeData(context).cardColor
                  : lightThemeData(context).cardColor,
              border: const OutlineInputBorder(),
              suffix: InkWell(
                  child: const Icon(Icons.replay),
                  onTap: () {
                    store.clientCreate.setTarefaTextSave('');
                    widget.controller.text = '';

                    FocusScope.of(context).requestFocus(FocusNode());
                  }),
              hintText: "Insira sua tarefa"),
        ),
      );
    });
  }
}
