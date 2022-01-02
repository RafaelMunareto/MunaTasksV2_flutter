import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_text_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/button_action_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/header_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class CardWidget extends StatefulWidget {
  final List<TarefaModel> tarefa;
  final Function delete;
  const CardWidget({Key? key, required this.tarefa, required this.delete})
      : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Accordion(
      maxOpenSections: 1,
      headerBackgroundColor: kPrimaryColor,
      children: [
        for (var linha in widget.tarefa)
          AccordionSection(
            isOpen: true,
            header: HeaderWidget(
              tarefa: linha,
            ),
            content: Wrap(
              children: [
                BodyTextWidget(
                  tarefa: linha,
                ),
                const Divider(),
                ButtonActionWidget(
                  tarefa: linha,
                  delete: delete,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
