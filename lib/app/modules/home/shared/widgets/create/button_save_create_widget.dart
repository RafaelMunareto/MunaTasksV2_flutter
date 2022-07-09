import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/users_selection_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/teams_selection_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

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
  bool envioMsg = false;
  List checkErrors() {
    if (store.clientCreate.tarefaModelSaveTexto != "" &&
        store.clientCreate.subtarefaTextSave != "" &&
        (store.clientCreate.createUser.id == '' ||
            store.clientCreate.subtarefaModelSaveTitle == '' ||
            store.clientCreate.users.isEmpty ||
            store.clientCreate.tarefaModelSaveEtiqueta.id == '')) {
      return [false, 'VERIFICAR ERROS'];
    }

    if (store.clientCreate.tarefaModelSaveTexto != "" &&
        store.clientCreate.subtarefaTextSave == "" &&
        store.clientCreate.createUser.id != '' &&
        store.clientCreate.subtarefaModelSaveTitle != '' &&
        store.clientCreate.users.isEmpty &&
        store.clientCreate.tarefaModelSaveEtiqueta.id == '') {
      return [false, 'VERIFICAR ERROS'];
    }

    if (store.clientCreate.tarefaModelSaveTexto != "" &&
        store.clientCreate.subtarefaTextSave != "" &&
        store.clientCreate.createUser.id != '' &&
        store.clientCreate.subtarefaModelSaveTitle != '' &&
        store.clientCreate.users.isNotEmpty &&
        store.clientCreate.tarefaModelSaveEtiqueta.id != '') {
      return store.clientCreate.editarSubtarefa
          ? [true, 'EDITAR SUBTAREFA']
          : [true, 'INCLUIR SUBTAREFA'];
    }

    if (store.clientCreate.tarefaModelSaveTexto == "" &&
        (store.clientCreate.users.isEmpty ||
            store.clientCreate.tarefaModelSaveEtiqueta.id == '')) {
      return [false, 'VERIFICAR ERROS'];
    }
    if (store.clientCreate.tarefaModelSaveTexto != "" &&
        (store.clientCreate.users.isEmpty ||
            store.clientCreate.tarefaModelSaveEtiqueta.id == '')) {
      return [false, 'VERIFICAR ERROS'];
    }

    if (store.clientCreate.tarefaModelSaveTexto != "" &&
        store.clientCreate.subtarefaTextSave == "" &&
        store.clientCreate.users.isNotEmpty &&
        store.clientCreate.tarefaModelSaveEtiqueta.id != '') {
      return store.clientCreate.tarefaId != ""
          ? [true, 'EDITAR TAREFA']
          : [true, 'SALVAR TAREFA'];
    }

    return [false, 'VERIFICAR ERROS'];
  }

  tarefaSave() {
    store.clientCreate.setLoadingTarefa(true);

    store.clientCreate.setTarefa();
    if (store.clientCreate.isValidTarefa) {
      if (store.clientCreate.tarefaId != '') {
        if (store.clientCreate.tarefaModelSave.id == '') {
          store.clientCreate.tarefaModelSave.id = store.clientCreate.tarefaId;
        }
        store.updateNewTarefa(store.clientCreate.tarefaModelSave).then((e) {
          if (!envioMsg) {
            SnackbarCustom().createSnackBar(
              "Tarefa editada com sucesso!",
              Colors.green,
              context,
            );
          }
          setState(() {
            envioMsg = false;
          });
        });
        store.clientCreate.setLoadingTarefa(false);
      } else {
        store.saveNewTarefa().then((e) {
          SnackbarCustom().createSnackBar(
            "Tarefa salva com sucesso!",
            Colors.green,
            context,
          );
        });
        store.clientCreate.setEditarSubtarefa(false);
        store.clientCreate.setEditar(false);
        store.clientCreate.setLoadingTarefa(false);
      }
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
      if (store.clientCreate.editarSubtarefa) {
        SnackbarCustom().createSnackBar(
          "Subtarefa editada com sucesso!",
          Colors.green,
          context,
        );
        setState(() {
          envioMsg = true;
        });
      } else {
        SnackbarCustom().createSnackBar(
          "Subtarefa salva com sucesso!",
          Colors.green,
          context,
        );
        setState(() {
          envioMsg = true;
        });
      }
    }
    tarefaSave();
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
                    (checkErrors()[0] ? Colors.blue : kDarkGrey),
                  ),
                ),
                onPressed: () async {
                  if (widget.texto.text == "") {
                    return SnackbarCustom().createSnackBar(
                      "Tarefa sem descrição, primeiro faça a descrição tarefa principal.",
                      Colors.red,
                      context,
                    );
                  }
                  if (store.clientCreate.validTitleTarefa() != null) {
                    return Future.delayed(const Duration(milliseconds: 1), () {
                      DialogButtom().showDialog(
                        const RadioEtiquetasFilterWidget(
                          create: true,
                        ),
                        store.client.theme,
                        widget.constraint,
                        context,
                      );
                    });
                  }
                  if (store.clientCreate.validaUserTarefa() != null) {
                    return Future.delayed(const Duration(milliseconds: 1), () {
                      DialogButtom().showDialog(
                          UsersSelectionWidget(
                            constraint: widget.constraint,
                          ),
                          store.client.theme,
                          widget.constraint,
                          context);
                    });
                  }
                  if (store.clientCreate.tarefaModelSaveTexto != '' &&
                      store.clientCreate.subtarefaTextSave == "") {
                    store.clientCreate.setEditarSubtarefa(false);
                    tarefaSave();
                  }
                  if ((store.clientCreate.createUser.id != '' ||
                          store.clientCreate.subtarefaModelSaveTitle != '') &&
                      widget.textoSubtarefa.text == "") {
                    store.clientCreate.setEditarSubtarefa(true);
                    store.clientCreate.setLoadingTarefa(false);
                    return SnackbarCustom().createSnackBar(
                      "Subtarefa sem descrição, primeiro faça a descrição tarefa principal.",
                      Colors.red,
                      context,
                    );
                  }
                  if (widget.textoSubtarefa.text != "") {
                    if (store.clientCreate.validTitleSubtarefa() != null) {
                      return Future.delayed(const Duration(milliseconds: 1),
                          () {
                        DialogButtom().showDialog(
                          CreateSubtarefaInsertWidget(
                            subtarefaInserSelection:
                                store.clientCreate.subtarefaModelSaveTitle,
                            setSubtarefaSelection:
                                store.clientCreate.setSubtarefaInsertCreate,
                          ),
                          store.client.theme,
                          widget.constraint,
                          context,
                        );
                      });
                    }
                    if (store.clientCreate.validaUserSubtarefa() != null) {
                      return Future.delayed(const Duration(milliseconds: 1),
                          () {
                        DialogButtom().showDialog(
                          const TeamsSelectionWidget(),
                          store.client.theme,
                          widget.constraint,
                          context,
                        );
                      });
                    } else {
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
                    : checkErrors()[0]
                        ? const Icon(Icons.add_circle, size: 18)
                        : const Icon(Icons.warning),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(checkErrors()[1]),
                ),
              );
            })),
      );
    });
  }
}
