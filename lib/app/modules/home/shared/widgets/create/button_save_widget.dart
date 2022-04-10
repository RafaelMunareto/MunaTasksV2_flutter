import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class ButtonSaveWidget extends StatelessWidget {
  const ButtonSaveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    errors() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erros'),
            content: SizedBox(
              width: kIsWeb && defaultTargetPlatform == TargetPlatform.windows
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: const ErrorsWidget(
                tarefa: true,
              ),
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
              padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
              child: store.clientCreate.loadingTarefa
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: () {
                        if (store.clientCreate.isValidTarefa) {
                          store.clientCreate.setTarefa();
                          store.saveNewTarefa().then((e) {
                            SnackbarCustom().createSnackBar(
                              "Tarefa salva com sucesso!",
                              Colors.red,
                              context,
                            );
                          }, onError: (error) {
                            SnackbarCustom().createSnackBar(
                                error.response?.data['error'].toString(),
                                Colors.red,
                                context);
                            Modular.to.pop();
                          });
                        } else {
                          errors();
                        }
                        FocusScope.of(context).unfocus();
                      },
                      icon: Icon(
                          store.clientCreate.id != ''
                              ? Icons.update
                              : Icons.add_circle,
                          size: 18),
                      label: Text(
                          store.clientCreate.id != '' ? "EDITAR" : 'SALVAR'),
                    ),
            );
          })
        ],
      ),
    );
  }
}
