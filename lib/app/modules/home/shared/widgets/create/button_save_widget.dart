import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class ButtonSaveWidget extends StatefulWidget {
  final double constraint;
  const ButtonSaveWidget({Key? key, required this.constraint})
      : super(key: key);

  @override
  State<ButtonSaveWidget> createState() => _ButtonSaveWidgetState();
}

class _ButtonSaveWidgetState extends State<ButtonSaveWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    errors(constraint) {
      DialogButtom().showDialog(
        ErrorsWidget(
          theme: store.client.theme,
          tarefa: true,
        ),
        store.client.theme,
        constraint,
        context,
      );
    }

    return Wrap(
      alignment: WrapAlignment.end,
      children: [
        Observer(builder: (_) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ElevatedButton(
              onPressed: () {
                store.clientCreate.setTarefa();
                if (store.clientCreate.isValidTarefa) {
                  if (store.clientCreate.tarefaModelSave.id != "") {
                    store.updateNewTarefa().then((e) {
                      SnackbarCustom().createSnackBar(
                        "Tarefa editada com sucesso!",
                        Colors.green,
                        context,
                      );
                      Modular.to.pop();
                    }, onError: (error) {
                      SnackbarCustom().createSnackBar(
                          error.response?.data['error'] ?? error?.message,
                          Colors.red,
                          context);
                    });
                  } else {
                    store.saveNewTarefa().then((e) {
                      SnackbarCustom().createSnackBar(
                        "Tarefa salva com sucesso!",
                        Colors.green,
                        context,
                      );

                      Modular.to.pop();
                    }, onError: (error) {
                      SnackbarCustom().createSnackBar(
                          error.response?.data['error'] ?? error?.message,
                          Colors.red,
                          context);
                    });
                  }
                } else {
                  errors(widget.constraint);
                }
              },
              child: store.clientCreate.loadingTarefa
                  ? const CircularProgressWidget()
                  : Text(
                      store.clientCreate.tarefaModelSave.id != ''
                          ? "EDITAR"
                          : 'SALVAR',
                    ),
            ),
          );
        })
      ],
    );
  }
}
