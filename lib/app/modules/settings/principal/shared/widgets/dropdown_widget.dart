import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';

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
            store.client.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      iconSize: 120,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.client.setLabel('Version');
              store.client.setEscolha(store.client.settings.version);
              Navigator.pop(context);
            },
            leading: const Text(
              "Version",
            ),
            trailing: const Icon(Icons.verified),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.client.setLabel('Order');
              store.client.setEscolha(store.client.settings.order);
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
              store.client.setLabel('Color');
              store.client.setEscolha(store.client.settings.color);
              Navigator.pop(context);
            },
            leading: const AutoSizeText(
              "Color",
              maxLines: 1,
            ),
            trailing: const Icon(Icons.color_lens_outlined),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.client.setLabel('Subtarefa');
              store.client.setEscolha(store.client.settings.subtarefaInsert);
              Navigator.pop(context);
            },
            leading: const AutoSizeText(
              "Subtarefa",
              maxLines: 1,
            ),
            trailing: const Icon(Icons.task),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.client.setLabel('Prioridade');
              store.client.setEscolha(store.client.settings.prioridade);
              Navigator.pop(context);
            },
            leading: const Text("Prioridade"),
            trailing: const Icon(Icons.numbers),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              store.client.setLabel('Tempo');
              store.client.setEscolha(store.client.settings.retard);
              Navigator.pop(context);
            },
            leading: const AutoSizeText(
              "Tempo",
              maxLines: 1,
            ),
            trailing: const Icon(Icons.timelapse_rounded),
          ),
        ),
      ],
    );
  }
}
