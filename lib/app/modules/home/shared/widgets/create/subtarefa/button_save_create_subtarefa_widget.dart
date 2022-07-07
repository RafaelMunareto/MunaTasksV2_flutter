import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class ButtonSaveCreateSubtarefaWidget extends StatefulWidget {
  final double constraint;
  final TextEditingController texto;
  final TextEditingController textoSubtarefa;
  const ButtonSaveCreateSubtarefaWidget({
    Key? key,
    required this.constraint,
    required this.texto,
    required this.textoSubtarefa,
  }) : super(key: key);

  @override
  State<ButtonSaveCreateSubtarefaWidget> createState() =>
      _ButtonSaveCreateSubtarefaWidgetState();
}

class _ButtonSaveCreateSubtarefaWidgetState
    extends State<ButtonSaveCreateSubtarefaWidget> {
  HomeStore store = Modular.get();
  errors(constraint, erro) {
    DialogButtom().showDialog(
      ErrorsWidget(
          constraint: constraint,
          theme: store.client.theme,
          tarefa: true,
          erro: erro),
      store.client.theme,
      constraint,
      context,
    );
  }

  subtarefaSave() {
    store.clientCreate.setLoadingTarefa(true);
    if (!store.clientCreate.editar) {
      store.clientCreate
          .setSubtarefaId(DateTime.now().millisecondsSinceEpoch.toString());
    }
    store.clientCreate.setSubtarefaTextSave(widget.textoSubtarefa.text);
    if (store.clientCreate.isValidSubtarefa) {
      store.clientCreate.setSubtarefas();
      store.clientCreate.setIdReferenceStaff(store.clientCreate.createUser);
      store.clientCreate.cleanSubaterafaText();
      widget.textoSubtarefa.text = '';
    } else {
      DialogButtom().showDialog(
        ErrorsWidget(
          constraint: widget.constraint,
          tarefa: false,
          theme: store.client.theme,
          erro: '',
        ),
        store.client.theme,
        widget.constraint,
        context,
      );
    }
  }

  tarefaSave() {
    store.clientCreate.setLoadingTarefa(true);
    store.clientCreate.setTarefa();
    if (store.clientCreate.isValidTarefa) {
      if (store.clientCreate.tarefaModelSave.id != "") {
        store.updateNewTarefa().then((e) {
          SnackbarCustom().createSnackBar(
            "Tarefa editada com sucesso!",
            Colors.green,
            context,
          );
        }, onError: (error) {
          errors(widget.constraint,
              error.response?.data['error'] ?? error?.message);
        });
      } else {
        store.saveNewTarefa().then((e) {
          SnackbarCustom().createSnackBar(
            "Tarefa salva com sucesso!",
            Colors.green,
            context,
          );

          if (store.clientCreate.tarefaModelSave.fase ==
              store.client.navigateBarSelection) {
            var newIndex = store.client.taskDio.length;
            final newItem = (List.of(store.client.taskDio)..shuffle()).first;
            store.client.taskDio.insert(newIndex, newItem);
          }
        }, onError: (error) {
          errors(widget.constraint,
              error.response?.data['error'] ?? error?.message);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();

    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(top: 8, left: 4, right: 8),
        child: Align(
            alignment: Alignment.bottomRight,
            child: Observer(builder: (_) {
              return ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    store.client.theme
                        ? darkThemeData(context).primaryColor
                        : lightThemeData(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  if (widget.texto.text != "") {
                    tarefaSave();
                    if (widget.textoSubtarefa.text != "") {
                      subtarefaSave();
                    }
                  }
                  FocusScope.of(context).unfocus();
                },
                icon: store.clientCreate.loadingTarefa
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.add_circle, size: 18),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    store.clientCreate.tarefaModelSave.id == ''
                        ? "CRIAR TAREFA"
                        : store.clientCreate.editar
                            ? 'EDITAR TAREFA'
                            : "SALVAR TAREFA",
                  ),
                ),
              );
            })),
      );
    });
  }
}
