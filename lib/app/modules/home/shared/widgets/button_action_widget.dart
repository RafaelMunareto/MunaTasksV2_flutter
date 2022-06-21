import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/shared/components/circular_p_min_widget.dart';

class ButtonActionWidget extends StatefulWidget {
  final TarefaDioModel tarefa;
  final int navigate;
  final Function save;
  final double constraint;
  const ButtonActionWidget(
      {Key? key,
      required this.tarefa,
      required this.navigate,
      required this.save,
      required this.constraint})
      : super(key: key);

  @override
  State<ButtonActionWidget> createState() => _ButtonActionWidgetState();
}

class _ButtonActionWidgetState extends State<ButtonActionWidget> {
  bool atualizando = false;

  atRemove() async {
    setState(() {
      atualizando = true;
    });
    await widget.save(widget.tarefa);
    setState(() {
      atualizando = false;
    });
  }

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
                atRemove();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: atualizando && navigate == 0 && widget.tarefa.fase == 1
                    ? const CircularPMinWidget()
                    : const Icon(
                        Icons.play_circle,
                        color: Colors.green,
                      ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 2;
                atRemove();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: atualizando && navigate == 0 && widget.tarefa.fase == 2
                    ? const CircularPMinWidget()
                    : const Icon(
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
                atRemove();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: atualizando && navigate == 1 && widget.tarefa.fase == 0
                    ? const CircularPMinWidget()
                    : const Icon(
                        Icons.pause_circle,
                        color: Colors.amber,
                      ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 2;
                atRemove();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: atualizando && navigate == 1 && widget.tarefa.fase == 2
                    ? const CircularPMinWidget()
                    : const Icon(
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
                atRemove();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: atualizando && navigate == 2 && widget.tarefa.fase == 0
                    ? const CircularPMinWidget()
                    : const Icon(
                        Icons.pause_circle,
                        color: Colors.amber,
                      ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                widget.tarefa.fase = 1;
                atRemove();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: atualizando && navigate == 2 && widget.tarefa.fase == 1
                    ? const CircularPMinWidget()
                    : const Icon(
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
