import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/actions_fase_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/date_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_user_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/users_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/prioridade_selection_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/users_selection_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class ButtonHeaderTarefaWidget extends StatefulWidget {
  final double constraint;
  final double tamanho;
  final int tipo;
  final TextEditingController? dateController;
  const ButtonHeaderTarefaWidget(
      {Key? key,
      required this.constraint,
      required this.tipo,
      required this.tamanho,
      this.dateController})
      : super(key: key);

  @override
  State<ButtonHeaderTarefaWidget> createState() =>
      _ButtonHeaderTarefaWidgetState();
}

class _ButtonHeaderTarefaWidgetState extends State<ButtonHeaderTarefaWidget> {
  HomeStore store = Modular.get();

  retornaTipo(int tipo) {
    switch (tipo) {
      case 0:
        return text(
            store.clientCreate.tarefaModelSaveEtiqueta.etiqueta == 'TODOS'
                ? 'Etiqueta'
                : store.clientCreate.tarefaModelSaveEtiqueta.icon != null
                    ? store.clientCreate.tarefaModelSaveEtiqueta.etiqueta
                    : 'Etiqueta');
      case 1:
        return text(ConvertIcon().nameStatus(store.clientCreate.faseTarefa));
      case 2:
        return Icon(
          store.clientCreate.tarefaModelPrioritario == 4
              ? Icons.flag_outlined
              : Icons.flag,
          color: Colors.black,
        );
      case 3:
        return UsersSaveWidget(
          constraint: widget.constraint,
        );
      case 4:
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: DateSaveWidget(
            dateController: widget.dateController!,
            constraint: widget.constraint,
          ),
        );
    }
  }

  text(text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: store.clientCreate.subtarefaModelSaveTitle != "" &&
                store.clientCreate.subtarefaModelSaveTitle != "Subtarefa"
            ? Colors.white
            : Colors.black,
      ),
    );
  }

  prioridade() {
    DialogButtom().showDialog(
      PrioridadeSelectionWidget(
        constraint: widget.constraint,
        create: true,
        prioridadeSelection: store.clientCreate.tarefaModelPrioritario,
        setPrioridadeSelection: store.clientCreate.setPrioridadeSaveSelection,
      ),
      store.client.theme,
      widget.constraint,
      context,
    );
  }

  retornaFuncaoTipo(int tipo) {
    switch (tipo) {
      case 0:
        return etiquetas();
      case 1:
        return actionFase();
      case 2:
        return prioridade();
      case 3:
        return users();
    }
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
    }
  }

  actionFase() {
    DialogButtom().showDialog(
      ActionsFaseWidget(
        faseList: store.client.fase,
        setActionsFase: store.clientCreate.setFaseTarefa,
        constraint: widget.constraint,
      ),
      store.client.theme,
      widget.constraint,
      context,
    );
  }

  users() {
    DialogButtom().showDialog(
        UsersSelectionWidget(
          constraint: widget.constraint,
          subtarefa: false,
        ),
        store.client.theme,
        widget.constraint,
        context);
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
      return GestureDetector(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: colors(widget.tipo),
              ),
              width: MediaQuery.of(context).size.width * widget.tamanho,
              height: MediaQuery.of(context).size.height * 0.05,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: retornaTipo(widget.tipo),
                  ),
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          retornaFuncaoTipo(widget.tipo);
        },
      );
    });
  }
}
