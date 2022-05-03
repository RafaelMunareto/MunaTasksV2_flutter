import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/actions_fase_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class ActionFaseSaveWidget extends StatefulWidget {
  final double constraint;
  const ActionFaseSaveWidget({Key? key, required this.constraint})
      : super(key: key);

  @override
  State<ActionFaseSaveWidget> createState() => _ActionFaseSaveWidgetState();
}

class _ActionFaseSaveWidgetState extends State<ActionFaseSaveWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();

    return Observer(builder: (_) {
      return GestureDetector(
        child: widget.constraint <= 100
            ? Icon(
                ConvertIcon().iconStatus(store.clientCreate.faseTarefa),
                color: ConvertIcon()
                    .colorStatusDark(store.clientCreate.faseTarefa),
              )
            : Chip(
                backgroundColor:
                    ConvertIcon().colorStatus(store.clientCreate.faseTarefa),
                label: Text(
                  ConvertIcon().nameStatus(store.clientCreate.faseTarefa),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.constraint >
                              LarguraLayoutBuilder().larguraModal
                          ? 14
                          : 10,
                      color: ConvertIcon()
                          .colorStatusDark(store.clientCreate.faseTarefa)),
                ),
                avatar: Icon(
                  ConvertIcon().iconStatus(store.clientCreate.faseTarefa),
                  color: ConvertIcon()
                      .colorStatusDark(store.clientCreate.faseTarefa),
                ),
              ),
        onTap: () => DialogButtom().showDialog(
          ActionsFaseWidget(
            faseList: store.client.fase,
            setActionsFase: store.clientCreate.setFaseTarefa,
            constraint: widget.constraint,
          ),
          store.client.theme,
          widget.constraint,
          context,
        ),
      );
    });
  }
}
