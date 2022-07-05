import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/button_header_widget.dart';

class CreateSubtarefaWidget extends StatefulWidget {
  final double constraint;
  const CreateSubtarefaWidget({
    Key? key,
    required this.constraint,
  }) : super(key: key);

  @override
  State<CreateSubtarefaWidget> createState() => _CreateSubtarefaWidgetState();
}

class _CreateSubtarefaWidgetState extends State<CreateSubtarefaWidget> {
  TextEditingController textSubtarefaController = TextEditingController();
  final HomeStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    textSubtarefaController.text = store.clientCreate.subtarefaTextSave;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonHeaderWidget(
                  constraint: widget.constraint,
                  tipo: 0,
                  textSubtarefaController: textSubtarefaController),
              ButtonHeaderWidget(
                  tipo: 1,
                  constraint: widget.constraint,
                  textSubtarefaController: textSubtarefaController),
              ButtonHeaderWidget(
                  tipo: 2,
                  constraint: widget.constraint,
                  textSubtarefaController: textSubtarefaController),
              ButtonHeaderWidget(
                  tipo: 3,
                  constraint: widget.constraint,
                  textSubtarefaController: textSubtarefaController),
            ],
          ),
          // ConstrainedBox(
          //   constraints: const BoxConstraints(minHeight: 50),
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          //     child: TextField(
          //       autocorrect: false,
          //       autofocus: false,
          //       controller: textSubtarefaController,
          //       minLines: 3,
          //       maxLines: 5,
          //       decoration: InputDecoration(
          //         suffixIcon: InkWell(
          //             child: const Icon(Icons.replay),
          //             onTap: () {
          //               setState(() {
          //                 store.clientCreate.setSubtarefaTextSave('');
          //                 textSubtarefaController.text = '';
          //                 FocusScope.of(context).requestFocus(FocusNode());
          //               });
          //             }),
          //         hintText: "Insira sua subtarefa",
          //       ),
          //     ),
          //   ),
          // ),
          // ConstrainedBox(
          //   constraints: const BoxConstraints(minHeight: 10),
          //   child: ButtonSaveCreateSubtarefaWidget(
          //     texto: textSubtarefaController,
          //     constraint: widget.constraint,
          //   ),
          // ),
          // if (store.clientCreate.subtarefas.isNotEmpty)
          //   Expanded(
          //       child: SubtarefasWidget(controller: textSubtarefaController)),
        ],
      );
    });
  }
}
