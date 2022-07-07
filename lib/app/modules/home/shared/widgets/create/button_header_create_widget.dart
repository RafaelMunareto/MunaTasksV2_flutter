import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/date_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/users_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/teams_selection_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

class ButtonHeaderCreateWidget extends StatefulWidget {
  final double constraint;
  final int tipo;
  final TextEditingController? dateController;
  final TextEditingController textSubtarefaController;
  const ButtonHeaderCreateWidget(
      {Key? key,
      required this.constraint,
      required this.tipo,
      required this.textSubtarefaController,
      this.dateController})
      : super(key: key);

  @override
  State<ButtonHeaderCreateWidget> createState() =>
      _ButtonHeaderCreateWidgetState();
}

class _ButtonHeaderCreateWidgetState extends State<ButtonHeaderCreateWidget> {
  HomeStore store = Modular.get();
  bool priorioritario = false;
  int fase = 0;
  int subfase = 0;
  retornaTipo(int tipo) {
    switch (tipo) {
      case 0:
        return Tooltip(
          message: store.clientCreate.tarefaModelSaveEtiqueta.etiqueta,
          child: Icon(
            store.clientCreate.tarefaModelSaveEtiqueta.icon != null
                ? IconData(store.clientCreate.tarefaModelSaveEtiqueta.icon ?? 0,
                    fontFamily: 'MaterialIcons')
                : Icons.bookmark,
            color: Colors.black,
          ),
        );
      case 1:
        return Tooltip(
            message: store.clientCreate.faseTarefa,
            child: Observer(builder: (_) {
              return Icon(
                ConvertIcon().iconFaseIconData(store.clientCreate.faseTarefa),
                color: Colors.black,
              );
            }));

      case 2:
        return Icon(
          store.clientCreate.tarefaModelPrioritario == 4
              ? Icons.flag_outlined
              : Icons.flag,
          color: Colors.black,
        );
      case 3:
        return UsersSaveWidget(constraint: widget.constraint);
      case 4:
        return SizedBox(
          width: 24,
          height: 24,
          child: DateSaveWidget(
            dateController: widget.dateController!,
            constraint: widget.constraint,
          ),
        );
      case 5:
        return const Tooltip(
            message: 'Limpa a subtarefa',
            child: Icon(Icons.add, color: Colors.black));
      case 6:
        return Tooltip(
          message: store.clientCreate.subtarefaModelSaveTitle,
          child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(Icons.business_center_rounded)),
        );
      case 7:
        return Tooltip(
          message: store.clientCreate.fase,
          child: Icon(
            ConvertIcon().iconFaseIconData(store.clientCreate.fase),
            color: Colors.black,
          ),
        );
      case 8:
        return usersSaveSubtarefa();
    }
  }

  retornaFuncaoTipo(int tipo) {
    switch (tipo) {
      case 0:
        return etiquetas();
      case 1:
        return actionFase(true, store.clientCreate.setFaseTarefa);
      case 2:
        return prioridade();
      case 5:
        return novo();
      case 6:
        return subtarefa();
      case 7:
        return actionFase(false, store.clientCreate.setFase);
    }
  }

  usersSaveSubtarefa() {
    return GestureDetector(
        onTap: () {
          store.clientCreate.setSubtarefaAction(true);
          DialogButtom().showDialog(
            const TeamsSelectionWidget(),
            store.client.theme,
            widget.constraint,
            context,
          );
        },
        child: Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: store.clientCreate.createUser.id != ''
                ? CircleAvatarWidget(
                    nameUser: store.clientCreate.createUser.name.name,
                    key: UniqueKey(),
                    url: store.clientCreate.imageUser,
                  )
                : const Icon(
                    Icons.people,
                    color: Colors.black,
                  )));
  }

  colors(int tipo) {
    switch (tipo) {
      case 0:
        return ConvertIcon()
            .convertColor(store.clientCreate.tarefaModelSaveEtiqueta.color);
      case 1:
        return ConvertIcon().colorStatusDark(store.clientCreate.faseTarefa);
      case 2:
        return ConvertIcon().convertColorFlaf(
          store.clientCreate.tarefaModelPrioritario,
        );
      case 3:
        return Colors.grey.shade300;
      case 4:
        return Colors.grey.shade300;
      case 5:
        return Colors.grey.shade300;
      case 6:
        return Colors.grey.shade300;
      case 7:
        return ConvertIcon().colorStatusDark(store.clientCreate.fase);
      case 8:
        return Colors.grey.shade300;
    }
  }

  actionSubtarefa(subtarefa) {
    store.clientCreate.setSubtarefaAction(subtarefa);
  }

  subtarefa() {
    DialogButtom().showDialog(
      CreateSubtarefaInsertWidget(
        subtarefaInserSelection: store.clientCreate.subtarefaModelSaveTitle,
        setSubtarefaSelection: store.clientCreate.setSubtarefaInsertCreate,
      ),
      store.client.theme,
      widget.constraint,
      context,
    );
  }

  novo() {
    store.clientCreate.cleanSubtarefa();
    store.clientCreate.setEditar(false);
    widget.textSubtarefaController.text = '';
  }

  text(text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.bold,
        color: store.clientCreate.subtarefaModelSaveTitle != "" &&
                store.clientCreate.subtarefaModelSaveTitle != "Subtarefa"
            ? Colors.white
            : Colors.black,
      ),
    );
  }

  prioridade() {
    setState(() {
      priorioritario = !priorioritario;
    });
    priorioritario
        ? store.clientCreate.setPrioridadeSaveSelection(1)
        : store.clientCreate.setPrioridadeSaveSelection(4);
  }

  actionFase(faseAction, Function function) {
    faseAction
        ? setState(() {
            fase = fase + 1;
            switch (fase) {
              case 0:
                function('pause');
                break;
              case 1:
                function('play');
                break;
              case 2:
                function('check');
                break;
              default:
                fase = 0;
                function('pause');
                break;
            }
          })
        : setState(() {
            subfase = subfase + 1;
            switch (subfase) {
              case 0:
                function('pause');
                break;
              case 1:
                function('play');
                break;
              case 2:
                function('check');
                break;
              default:
                subfase = 0;
                function('pause');
                break;
            }
          });
  }

  etiquetas() {
    DialogButtom().showDialog(
      const RadioEtiquetasFilterWidget(
        create: true,
      ),
      store.client.theme,
      widget.constraint,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: colors(widget.tipo),
              ),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.14),
                    child: retornaTipo(widget.tipo),
                  ),
                ),
              ),
            ),
          ),
          onTap: () {
            retornaFuncaoTipo(widget.tipo);
          },
        ),
      );
    });
  }
}
