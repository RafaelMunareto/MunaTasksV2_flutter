import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/modules/settings/principal/widgets/dialog_input_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  final PrincipalStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Observer(
        builder: (_) {
          return Text(
            store.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.setLabel('Order');
              store.setEscolha(store.settings.order);
              Navigator.pop(context);
            },
            leading: const Text(
              "Order",
            ),
            trailing: const Icon(Icons.sort),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.setLabel('Color');
              store.setEscolha(store.settings.color);
              Navigator.pop(context);
            },
            leading: const Text("Color"),
            trailing: const Icon(Icons.color_lens_outlined),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.setLabel('Subtarefa');
              store.setEscolha(store.settings.subtarefaInsert);
              Navigator.pop(context);
            },
            leading: const Text("Subtarefa"),
            trailing: const Icon(Icons.task),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.setLabel('Prioridade');
              store.setEscolha(store.settings.prioridade);
              Navigator.pop(context);
            },
            leading: const Text("Prioridade"),
            trailing: const Icon(Icons.numbers),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.setLabel('Tempo');
              store.setEscolha(store.settings.retard);
              Navigator.pop(context);
            },
            leading: const Text("Tempo"),
            trailing: const Icon(Icons.timelapse_rounded),
          ),
        ),
      ],
    );
  }
}
