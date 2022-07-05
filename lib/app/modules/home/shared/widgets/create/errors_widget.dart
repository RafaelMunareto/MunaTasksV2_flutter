import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_user_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/users_selection_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

class ErrorsWidget extends StatefulWidget {
  final bool tarefa;
  final bool theme;
  final String erro;
  final double constraint;
  const ErrorsWidget(
      {Key? key,
      required this.constraint,
      required this.theme,
      this.tarefa = false,
      required this.erro})
      : super(key: key);

  @override
  State<ErrorsWidget> createState() => _ErrorsWidgetState();
}

class _ErrorsWidgetState extends State<ErrorsWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    if (store.clientCreate.validaUserTarefa() != null && widget.tarefa) {
      Future.delayed(const Duration(milliseconds: 1), () {
        DialogButtom().showDialog(
            UsersSelectionWidget(
              constraint: widget.constraint,
              subtarefa: false,
            ),
            store.client.theme,
            widget.constraint,
            context);
      });
    }
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
          const CreateUserSubtarefaWidget(
            subtarefa: false,
          ),
          store.client.theme,
          widget.constraint,
          context,
        );
      });
    } else {
      Modular.to.pop();
    }

    List? errors;
    !widget.tarefa
        ? errors = [
            store.clientCreate.validTextoSubtarefa(),
            widget.erro != '' ? widget.erro : null,
          ]
        : errors = [
            store.clientCreate.validTextoTarefa(),
            store.clientCreate.validaDataTarefa(),
            widget.erro != '' ? widget.erro : null,
          ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(4),
            itemCount: errors.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              var erro = errors![index];
              return ListTile(
                leading: erro == null
                    ? const Text('')
                    : Icon(
                        Icons.error,
                        color: widget.theme ? Colors.redAccent : Colors.red,
                      ),
                title: Text(
                  erro ?? '',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: widget.theme ? Colors.white : Colors.red,
                    fontSize: 12,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
