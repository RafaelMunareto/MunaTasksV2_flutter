import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/date_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/users_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/users_selection_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

class ButtonHeaderTarefaWidget extends StatefulWidget {
  final double constraint;

  final int tipo;
  final TextEditingController? dateController;
  const ButtonHeaderTarefaWidget(
      {Key? key,
      required this.constraint,
      required this.tipo,
      this.dateController})
      : super(key: key);

  @override
  State<ButtonHeaderTarefaWidget> createState() =>
      _ButtonHeaderTarefaWidgetState();
}

class _ButtonHeaderTarefaWidgetState extends State<ButtonHeaderTarefaWidget> {
  HomeStore store = Modular.get();
  bool priorioritario = false;
  int fase = 0;
  retornaTipo(int tipo) {
    switch (tipo) {
      case 0:
        return Icon(
          store.clientCreate.tarefaModelSaveEtiqueta.icon != null
              ? IconData(store.clientCreate.tarefaModelSaveEtiqueta.icon ?? 0,
                  fontFamily: 'MaterialIcons')
              : Icons.bookmark,
          color: Colors.black,
        );
      case 1:
        return GestureDetector(
          child: Icon(
            ConvertIcon().iconFaseIconData(store.clientCreate.faseTarefa),
            color: Colors.black,
          ),
          onTap: () => actionFase(),
        );

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
          width: 24,
          height: 24,
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
    setState(() {
      fase = fase + 1;
      switch (fase) {
        case 0:
          store.clientCreate.setFaseTarefa('pause');
          break;
        case 1:
          store.clientCreate.setFaseTarefa('play');
          break;
        case 2:
          store.clientCreate.setFaseTarefa('check');
          break;
        default:
          fase = 0;
          store.clientCreate.setFaseTarefa('pause');
          break;
      }
    });
    return PopupMenuButton(
      icon: const Icon(
        Icons.pause,
        color: Colors.black,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => store.clientCreate.setFaseTarefa('pause'),
          child: const ListTile(
            leading: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.pause_circle_outline,
                color: Colors.amber,
              ),
            ),
            title: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'Backlog',
                  maxLines: 1,
                )),
          ),
        ),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => store.clientCreate.setFaseTarefa('play'),
          child: const ListTile(
            leading: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.green,
              ),
            ),
            title: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'Fazendo',
                  maxLines: 1,
                )),
          ),
        ),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => store.clientCreate.setFaseTarefa('check'),
          child: const ListTile(
            leading: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.blue,
              ),
            ),
            title: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'Feito',
                  maxLines: 1,
                )),
          ),
        ),
      ],
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
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: colors(widget.tipo),
            ),
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
        onTap: () {
          retornaFuncaoTipo(widget.tipo);
        },
      );
    });
  }
}
