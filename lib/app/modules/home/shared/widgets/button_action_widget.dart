import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class ButtonActionWidget extends StatelessWidget {
  final TarefaModel tarefa;
  final Function delete;
  const ButtonActionWidget(
      {Key? key, required this.tarefa, required this.delete})
      : super(key: key);

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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.play_circle,
                    color: Colors.yellow,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.task_alt,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      dialogDelete(
                          tarefa.texto, tarefa.reference.toString(), context);
                    },
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dialogDelete(String message, String reference, context) {
    return AlertDialog(
      title: const Text('Tem certeza que deseja deletar?'),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            SnackbarCustom().createSnackBar('Cancelado', Colors.grey, context);
          },
          child: const Text('CANCELAR'),
        ),
        ElevatedButton(
          onPressed: () {
            delete(reference);
            SnackbarCustom()
                .createSnackBar('Deletado com sucesso!', Colors.green, context);
          },
          child: const Text('DELETAR'),
        ),
      ],
    );
  }
}
