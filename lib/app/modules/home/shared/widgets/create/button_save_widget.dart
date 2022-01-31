import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';

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
          return const AlertDialog(
            title: Text('Erros'),
            content: ErrorsWidget(),
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
              padding: const EdgeInsets.fromLTRB(0, 16, 2, 2),
              child: store.clientCreate.loadingTarefa
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: () {
                        store.clientCreate.isValidSubtarefa
                            ? store.saveNewTarefa()
                            : errors();
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(Icons.add_circle, size: 18),
                      label: const Text("SALVAR"),
                    ),
            );
          })
        ],
      ),
    );
  }
}
