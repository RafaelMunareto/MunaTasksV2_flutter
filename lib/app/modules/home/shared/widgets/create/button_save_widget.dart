import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class ButtonSaveWidget extends StatelessWidget {
  final AnimationController? controller;
  const ButtonSaveWidget({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    errors() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Erros'),
            content: ErrorsWidget(
              tarefa: true,
            ),
          );
        },
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Observer(builder: (_) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 2, 2),
              child: store.clientCreate.loadingTarefa
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: () {
                        if (store.clientCreate.isValidTarefa) {
                          controller!.reverse();
                          store.client.setExpand(false);
                          store.clientCreate.setTarefa();
                          store.saveNewTarefa();
                          SnackbarCustom().createSnackBar(
                              'Salvo com sucesso!', Colors.green, context);
                        } else {
                          errors();
                        }
                        FocusScope.of(context).unfocus();
                      },
                      icon: Icon(
                          store.clientCreate.reference != null
                              ? Icons.update
                              : Icons.add_circle,
                          size: 18),
                      label: Text(store.clientCreate.reference != null
                          ? "EDITAR"
                          : 'SALVAR'),
                    ),
            );
          })
        ],
      ),
    );
  }
}
