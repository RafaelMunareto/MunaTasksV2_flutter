import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class ButtonActionWidget extends StatefulWidget {
  final TarefaModel tarefa;
  final int navigate;
  final Function save;
  const ButtonActionWidget(
      {Key? key,
      required this.tarefa,
      required this.navigate,
      required this.save})
      : super(key: key);

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
        SizedBox(
            //decoration: const BoxDecoration(color: Colors.white),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: convertButton(widget.navigate),
            )),
      ],
    );
  }

  convertButton(int navigate) {
    switch (navigate) {
      case 0:
        return Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 1;
                widget.save(widget.tarefa);
              },
              child: const Icon(
                Icons.play_circle,
                color: Colors.amber,
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 1;
                widget.save(widget.tarefa);
              },
              child: const Icon(
                Icons.check_circle,
                color: kPrimaryColor,
              ),
            ),
          ],
        );
      case 1:
        return Wrap(
          alignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 0;
                widget.save(widget.tarefa);
              },
              child: const Icon(
                Icons.pause_circle,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 2;
                widget.save(widget.tarefa);
              },
              child: const Icon(
                Icons.task_alt,
                color: kPrimaryColor,
              ),
            ),
          ],
        );
      case 2:
        return Wrap(
          alignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 0;
                widget.save(widget.tarefa);
              },
              child: const Icon(
                Icons.pause_circle,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 1;
                widget.save(widget.tarefa);
              },
              child: const Icon(
                Icons.play_circle,
                color: Colors.amber,
              ),
            ),
          ],
        );
    }
  }
}
