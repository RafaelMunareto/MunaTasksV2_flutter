import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';

class ErrorsWidget extends StatelessWidget {
  final bool tarefa;
  final bool theme;
  const ErrorsWidget({
    Key? key,
    required this.theme,
    this.tarefa = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    List? errors;
    !tarefa
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.separated(
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
                  ? const AutoSizeText('')
                  : Icon(
                      Icons.error,
                      color: theme ? Colors.redAccent : Colors.red,
                    ),
              title: Text(
                erro ?? '',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: theme ? Colors.white : Colors.red,
                  fontSize: 12,
                ),
              ),
            );
          }),
    );
  }
}
