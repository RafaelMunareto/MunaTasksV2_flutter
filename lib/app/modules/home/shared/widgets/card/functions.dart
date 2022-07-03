import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/simple_button_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class Functions {
  dialogDelete(context, tarefa, store) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 200,
          height: 200,
          child: AlertDialog(
            key: Key(tarefa.id!),
            title: Text(
              'Excluir Tarefa',
              style: TextStyle(
                  color: store.client.theme
                      ? darkThemeData(context).primaryColor
                      : lightThemeData(context).primaryColor),
            ),
            content: const Text(
              'Tem certeza que deseja excluír a tarefa ?',
              maxLines: 1,
            ),
            actions: [
              SimpleButtonWidget(
                theme: store.client.theme,
                buttonName: 'CANCELAR',
                popUp: true,
              ),
              SimpleButtonWidget(
                theme: store.client.theme,
                buttonName: 'EXCLUIR',
                popUp: true,
                function: store.deleteDioTasks,
                dataFunction: tarefa,
                scnack: true,
                msgSnack: 'Deletado com sucesso!',
                delete: true,
                getFase: store.getDioFase(),
              ),
            ],
          ),
        );
      },
    );
  }
}
