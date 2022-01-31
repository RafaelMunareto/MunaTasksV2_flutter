import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';

class ErrorsWidget extends StatelessWidget {
  final bool tarefa;
  const ErrorsWidget({
    Key? key,
    this.tarefa = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    List? errors;
    tarefa
        ? errors = [
            store.clientCreate.validTextoSubtarefa(),
            store.clientCreate.validTitleSubtarefa(),
            store.clientCreate.validaUserSubtarefa(),
          ]
        : errors = [
            store.clientCreate.validTextoTarefa(),
            store.clientCreate.validTitleTarefa(),
            store.clientCreate.validaUserTarefa(),
            store.clientCreate.validaDataTarefa(),
          ];

    return Wrap(
      children: [
        for (var erro in errors)
          erro != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: SizedBox(
                    child: Text(
                      erro.toString(),
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                )
              : Container(),
      ],
    );
  }
}
