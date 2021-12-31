import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_text_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/button_action_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/header_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class CardWidget extends StatefulWidget {
  final List<TarefaModel> tarefa;
  const CardWidget({Key? key, required this.tarefa}) : super(key: key);

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
        for (var i = 0; i < widget.tarefa.length; i++)
          AccordionSection(
            isOpen: true,
            header: HeaderWidget(
              tarefa: widget.tarefa[i],
            ),
            content: Wrap(
              children: [
                BodyTextWidget(
                  tarefa: widget.tarefa[i],
                ),
                const Divider(),
                const ButtonActionWidget(),
              ],
            ),
          ),
      ],
    );
  }
}
