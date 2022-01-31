import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/actions_fase_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class ActionFaseSaveWidget extends StatefulWidget {
  final String title;
  const ActionFaseSaveWidget({Key? key, this.title = "ActionFaseSaveWidget"})
      : super(key: key);

  @override
  State<ActionFaseSaveWidget> createState() => _ActionFaseSaveWidgetState();
}

class _ActionFaseSaveWidgetState extends State<ActionFaseSaveWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    _actions() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fase'),
            content: ActionsFaseWidget(
              faseList: store.clientCreate.faseList,
              setActionsFase: store.clientCreate.setFaseTarefa,
            ),
          );
        },
      );
    }

    return Observer(builder: (_) {
      return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
          child: Chip(
            backgroundColor:
                ConvertIcon().colorStatus(store.clientCreate.faseTarefa),
            label: Text(
              ConvertIcon().nameStatus(store.clientCreate.faseTarefa),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ConvertIcon()
                      .colorStatusDark(store.clientCreate.faseTarefa)),
            ),
            avatar: Icon(
              ConvertIcon().iconStatus(store.clientCreate.faseTarefa),
              color:
                  ConvertIcon().colorStatusDark(store.clientCreate.faseTarefa),
            ),
          ),
        ),
        onTap: () => _actions(),
      );
    });
  }
}
