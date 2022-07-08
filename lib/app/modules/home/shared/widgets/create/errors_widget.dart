import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/users_selection_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/teams_selection_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class ErrorsWidget extends StatefulWidget {
  final bool tarefa;
  final bool theme;
  final double constraint;
  const ErrorsWidget({
    Key? key,
    required this.constraint,
    required this.theme,
    this.tarefa = false,
  }) : super(key: key);

  @override
  State<ErrorsWidget> createState() => _ErrorsWidgetState();
}

class _ErrorsWidgetState extends State<ErrorsWidget> {
  HomeStore store = Modular.get();

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
    }
  }

  subtarefaSave() async {
    store.clientCreate.setLoadingTarefa(true);
    if (!store.clientCreate.editar) {
      store.clientCreate
          .setSubtarefaId(DateTime.now().millisecondsSinceEpoch.toString());
    }
    store.clientCreate
        .setSubtarefaTextSave(store.clientCreate.subtarefaTextSave);
    if (store.clientCreate.isValidSubtarefa) {
      store.clientCreate.setSubtarefas();
      store.clientCreate.setSubtarefaTextSave('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    if (store.clientCreate.validTitleTarefa() != null && widget.tarefa) {
      Future.delayed(const Duration(milliseconds: 1), () {
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
    if (store.clientCreate.validaUserTarefa() != null && widget.tarefa) {
      Future.delayed(const Duration(milliseconds: 1), () {
        DialogButtom().showDialog(
            UsersSelectionWidget(
              constraint: widget.constraint,
            ),
            store.client.theme,
            widget.constraint,
            context);
      });
    }
    //subtarefa
    if (store.clientCreate.validTitleSubtarefa() != null && !widget.tarefa) {
      Future.delayed(const Duration(milliseconds: 1), () {
        DialogButtom().showDialog(
          CreateSubtarefaInsertWidget(
            subtarefaInserSelection: store.clientCreate.subtarefaModelSaveTitle,
            setSubtarefaSelection: store.clientCreate.setSubtarefaInsertCreate,
          ),
          store.client.theme,
          widget.constraint,
          context,
        );
      });
    }
    if (store.clientCreate.validaUserSubtarefa() != null && !widget.tarefa) {
      Future.delayed(const Duration(milliseconds: 1), () {
        DialogButtom().showDialog(
          const TeamsSelectionWidget(),
          store.client.theme,
          widget.constraint,
          context,
        );
      });
    }
    if (widget.tarefa) {
      tarefaSave();
    } else {
      subtarefaSave();
    }

    return Container();
  }
}
