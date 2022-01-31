import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';

class ButtonSaveWidget extends StatelessWidget {
  const ButtonSaveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
            child: ElevatedButton.icon(
              onPressed: () {
                store.clientCreate.setTarefa();
              },
              icon: const Icon(Icons.add, size: 18),
              label: store.clientCreate.loading
                  ? const CircularProgressIndicator()
                  : const Text("SALVAR"),
            ),
          ),
        ],
      ),
    );
  }
}
