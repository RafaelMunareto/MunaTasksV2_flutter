import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class ButtonActionWidget extends StatefulWidget {
  final TarefaModel tarefa;
  final Function deleteTasks;
  final int navigate;
  final Function save;
  const ButtonActionWidget(
      {Key? key,
      required this.tarefa,
      required this.deleteTasks,
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
            child: Divider(
              height: 6,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Container(
            decoration: const BoxDecoration(color: Colors.black54),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: convertButton(widget.navigate),
            )),
      ],
    );
  }

  dialogDelete(String message, TarefaModel tarefa, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tem certeza que deseja deletar?'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Modular.to.pop();
                SnackbarCustom()
                    .createSnackBar('Cancelado', Colors.grey, context);
              },
              child: const Text('CANCELAR'),
            ),
            TextButton(
              onPressed: () {
                Modular.to.pop();
                widget.deleteTasks(tarefa);
                SnackbarCustom().createSnackBar(
                    'Deletado com sucesso!', Colors.green, context);
              },
              child: const Text('DELETAR'),
            ),
          ],
        );
      },
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
                color: Colors.yellow,
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.tarefa.fase = 1;
                widget.save(widget.tarefa);
              },
              child: const Icon(
                Icons.task_alt,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  dialogDelete(widget.tarefa.texto, widget.tarefa, context);
                },
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            )
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
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  dialogDelete(widget.tarefa.texto, widget.tarefa, context);
                },
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            )
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
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  dialogDelete(widget.tarefa.texto, widget.tarefa, context);
                },
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            )
          ],
        );
    }
  }
}
