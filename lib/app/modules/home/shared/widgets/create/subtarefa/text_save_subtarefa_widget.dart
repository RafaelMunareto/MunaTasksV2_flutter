import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class TextSaveSubtarefaWidget extends StatefulWidget {
  final TextEditingController controller;
  const TextSaveSubtarefaWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<TextSaveSubtarefaWidget> createState() =>
      _TextSaveSubtarefaWidgetState();
}

class _TextSaveSubtarefaWidgetState extends State<TextSaveSubtarefaWidget> {
  final HomeStore store = Modular.get();

  @override
  void initState() {
    widget.controller.text = store.clientCreate.subtarefaTextSave;
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
          onChanged: (value) => store.clientCreate.setSubtarefaTextSave(value),
          minLines: 15,
          maxLines: 20,
          decoration: InputDecoration(
              filled: true,
              fillColor: store.client.theme
                  ? darkThemeData(context).cardColor
                  : lightThemeData(context).cardColor,
              border: const OutlineInputBorder(),
              suffix: InkWell(
                  child: const Icon(Icons.replay),
                  onTap: () {
                    store.clientCreate.setSubtarefaTextSave('');
                    widget.controller.text = '';

                    FocusScope.of(context).requestFocus(FocusNode());
                  }),
              hintText: "Insira sua subtarefa"),
        ),
      );
    });
  }
}
