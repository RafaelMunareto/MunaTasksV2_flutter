import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class ButtonActionWidget extends StatefulWidget {
  final TarefaDioModel tarefa;
  final int navigate;
  final Function save;
  const ButtonActionWidget({
    Key? key,
    required this.tarefa,
    required this.navigate,
    required this.save,
  }) : super(key: key);

  @override
  State<ButtonActionWidget> createState() => _ButtonActionWidgetState();
}

class _ButtonActionWidgetState extends State<ButtonActionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.88,
          ),
        ),
        const Divider(),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: convertButton(widget.navigate),
          ),
        ),
      ],
    );
  }

  convertButton(int navigate) {
    switch (navigate) {
      case 0:
        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 1;
                widget.save(widget.tarefa);
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.play_circle,
                  color: Colors.green,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 2;
                widget.save(widget.tarefa);
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      case 1:
        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 0;
                widget.save(widget.tarefa);
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.pause_circle,
                  color: Colors.amber,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 2;
                widget.save(widget.tarefa);
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      case 2:
        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 0;
                widget.save(widget.tarefa);
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.pause_circle,
                  color: Colors.amber,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 1;
                widget.save(widget.tarefa);
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.play_circle,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
    }
  }
}
