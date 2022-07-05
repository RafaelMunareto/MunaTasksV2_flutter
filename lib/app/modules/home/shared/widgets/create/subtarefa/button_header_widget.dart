import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/actions_fase_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_user_subtarefa_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class ButtonHeaderWidget extends StatefulWidget {
  final double constraint;
  final int tipo;
  final TextEditingController textSubtarefaController;
  const ButtonHeaderWidget(
      {Key? key,
      required this.constraint,
      required this.tipo,
      required this.textSubtarefaController})
      : super(key: key);

  @override
  State<ButtonHeaderWidget> createState() => _ButtonHeaderWidgetState();
}

class _ButtonHeaderWidgetState extends State<ButtonHeaderWidget> {
  HomeStore store = Modular.get();

  retornaTipo(int tipo) {
    switch (tipo) {
      case 0:
        return 'Novo';
      case 1:
        return store.clientCreate.subtarefaModelSaveTitle != ""
            ? store.clientCreate.subtarefaModelSaveTitle
            : 'Subtarefa';
      case 2:
        return ConvertIcon().nameStatus(store.clientCreate.fase);
      case 3:
        return 'Equipe';
    }
  }

  retornaFuncaoTipo(int tipo) {
    switch (tipo) {
      case 0:
        return novo();
      case 1:
        return subtarefa();
      case 2:
        return actionFase();
      case 3:
        return users();
    }
  }

  colors(int tipo) {
    switch (tipo) {
      case 0:
        return store.clientCreate.subtarefaModelSaveTitle != "" &&
                store.clientCreate.subtarefaModelSaveTitle != "Subtarefa"
            ? Colors.blue
            : Colors.grey.shade500;
      case 1:
        return store.clientCreate.subtarefaModelSaveTitle != "" &&
                store.clientCreate.subtarefaModelSaveTitle != "Subtarefa"
            ? Colors.blue
            : Colors.grey.shade500;
      case 2:
        return ConvertIcon().colorStatusDark(store.clientCreate.fase);
      case 3:
        return Colors.grey.shade500;
    }
  }

  novo() {
    widget.textSubtarefaController.text = '';
    store.clientCreate
        .setSubtarefaTextSave(widget.textSubtarefaController.text);
    store.clientCreate.cleanSubtarefa();
    store.clientCreate.setEditar(false);
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
    store.clientCreate
        .setSubtarefaTextSave(widget.textSubtarefaController.text);
  }

  actionFase() {
    store.clientCreate
        .setSubtarefaTextSave(widget.textSubtarefaController.text);
    DialogButtom().showDialog(
      ActionsFaseWidget(
        faseList: store.client.fase,
        setActionsFase: store.clientCreate.setFase,
        constraint: widget.constraint,
      ),
      store.client.theme,
      widget.constraint,
      context,
    );
  }

  users() {
    store.clientCreate
        .setSubtarefaTextSave(widget.textSubtarefaController.text);
    DialogButtom().showDialog(
      CreateUserSubtarefaWidget(
        subtarefa: false,
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
              width: widget.constraint >= LarguraLayoutBuilder().telaPc
                  ? MediaQuery.of(context).size.width * 0.24
                  : MediaQuery.of(context).size.width * 0.21,
              height: MediaQuery.of(context).size.height * 0.05,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Center(
                  child: store.clientCreate.imageUser != "" && widget.tipo == 3
                      ? CircleAvatarWidget(
                          nameUser: store.clientCreate.createUser.name.name,
                          url: store.clientCreate.imageUser,
                        )
                      : Text(
                          retornaTipo(widget.tipo),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: store.clientCreate.subtarefaModelSaveTitle !=
                                        "" &&
                                    store.clientCreate
                                            .subtarefaModelSaveTitle !=
                                        "Subtarefa"
                                ? Colors.white
                                : Colors.black,
                          ),
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
