import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/actions_fase_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class CreateSubtarefaWidget extends StatefulWidget {
  final dynamic subtarefaList;
  final String subtarefaInserSelection;
  final Function setSubtarefaSelection;
  final dynamic theme;
  final Function setFase;
  final dynamic faseList;
  final String fase;
  const CreateSubtarefaWidget({
    Key? key,
    required this.subtarefaList,
    required this.subtarefaInserSelection,
    required this.setSubtarefaSelection,
    required this.setFase,
    required this.faseList,
    required this.theme,
    required this.fase,
  }) : super(key: key);

  @override
  State<CreateSubtarefaWidget> createState() => _CreateSubtarefaWidgetState();
}

class _CreateSubtarefaWidgetState extends State<CreateSubtarefaWidget> {
  @override
  Widget build(BuildContext context) {
    _subtarefa() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Subtarefa'),
            content: CreateSubtarefaInsertWidget(
              subtarefaInserSelection: widget.subtarefaInserSelection,
              setSubtarefaSelection: widget.setSubtarefaSelection,
              subtarefaList: widget.subtarefaList,
            ),
          );
        },
      );
    }

    _actions() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fase'),
            content: ActionsFaseWidget(
              faseList: widget.faseList,
              setActionsFase: widget.setFase,
            ),
          );
        },
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: widget.theme ? Colors.black38 : Colors.black12,
          borderRadius: BorderRadius.circular(4)),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                backgroundColor:
                    widget.theme ? Colors.black38 : Colors.grey[100],
                label: Text(widget.subtarefaInserSelection != ""
                    ? widget.subtarefaInserSelection
                    : 'Subtarefa'),
                avatar: const Icon(Icons.work, color: Colors.grey),
              ),
            ),
            onTap: () => _subtarefa(),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                backgroundColor: ConvertIcon().colorStatus(widget.fase),
                label: Text(
                  ConvertIcon().nameStatus(widget.fase),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ConvertIcon().colorStatusDark(widget.fase)),
                ),
                avatar: Icon(ConvertIcon().iconStatus(widget.fase),
                    color: ConvertIcon().colorStatusDark(widget.fase)),
              ),
            ),
            onTap: () => _actions(),
          ),
        ],
      ),
    );
  }
}
