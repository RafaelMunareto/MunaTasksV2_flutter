import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class ButtonSaveCreateWidget extends StatefulWidget {
  final double constraint;
  final TextEditingController texto;
  final TextEditingController textoSubtarefa;
  const ButtonSaveCreateWidget({
    Key? key,
    required this.constraint,
    required this.texto,
    required this.textoSubtarefa,
  }) : super(key: key);

  @override
  State<ButtonSaveCreateWidget> createState() => _ButtonSaveCreateWidgetState();
}

class _ButtonSaveCreateWidgetState extends State<ButtonSaveCreateWidget> {
  HomeStore store = Modular.get();
  errors() {
    return ErrorsWidget(
        constraint: widget.constraint, theme: store.client.theme, tarefa: true);
  }

  tarefaSave() {
    store.clientCreate.setLoadingTarefa(true);
    if (store.clientCreate.createUser.id != '') {
      store.clientCreate
          .setTarefaId(DateTime.now().millisecondsSinceEpoch.toString());
      store.clientCreate.setIdReferenceStaff(store.clientCreate.createUser);
    }
    store.clientCreate.setTarefa();
    if (store.clientCreate.isValidTarefa) {
      if (store.clientCreate.tarefaModelSave.id != "") {
        store.updateNewTarefa().then((e) {
          SnackbarCustom().createSnackBar(
            "Tarefa editada com sucesso!",
            Colors.green,
            context,
          );
        });
      } else {
        store.saveNewTarefa().then((e) {
          SnackbarCustom().createSnackBar(
            "Tarefa salva com sucesso!",
            Colors.green,
            context,
          );
        });
      }
    } else {
      errors();
    }
  }

  subtarefaSave() async {
    store.clientCreate.setLoadingTarefa(true);
    if (!store.clientCreate.editar) {
      store.clientCreate
          .setSubtarefaId(DateTime.now().millisecondsSinceEpoch.toString());
    }
    store.clientCreate.setSubtarefaTextSave(widget.textoSubtarefa.text);
    if (store.clientCreate.isValidSubtarefa) {
      store.clientCreate.setSubtarefas();
      widget.textoSubtarefa.text = '';
    } else {
      errors();
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();

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
              onPressed: () async {
                if (widget.texto.text == "") {
                  SnackbarCustom().createSnackBar(
                    "Tarefa sem descrição, primeiro faça a descrição tarefa principal.",
                    Colors.red,
                    context,
                  );
                }
                if (widget.texto.text != "") {
                  tarefaSave();
                  if (store.clientCreate.createUser.id != '' &&
                      store.clientCreate.subtarefaModelSaveTitle != '' &&
                      widget.textoSubtarefa.text == "") {
                    SnackbarCustom().createSnackBar(
                      "Subtarefa sem descrição, primeiro faça a descrição tarefa principal.",
                      Colors.red,
                      context,
                    );
                    store.clientCreate.setLoadingTarefa(false);
                    return;
                  }
                  if (widget.textoSubtarefa.text != "") {
                    subtarefaSave();
                  }
                }
                store.clientCreate.setLoadingTarefa(false);
                FocusScope.of(context).unfocus();
                store.clientCreate.setEditar(false);
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
  }
}
