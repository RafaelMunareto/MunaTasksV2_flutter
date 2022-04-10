import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/sub_item_save_widget.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class SubtarefasWidget extends StatefulWidget {
  const SubtarefasWidget({Key? key}) : super(key: key);

  @override
  State<SubtarefasWidget> createState() => _SubtarefasWidgetState();
}

class _SubtarefasWidgetState extends State<SubtarefasWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Observer(
        builder: (_) {
          return store.clientCreate.loadingSubtarefa
              ? const CircularProgressIndicator()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4),
                  itemCount: store.clientCreate.subtarefas.length,
                  itemBuilder: (BuildContext context, int index) {
                    var model = store.clientCreate.subtarefas[index];
                    return Dismissible(
                      background: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Excluir',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          store.clientCreate.removeDismissSubtarefa(model);
                        });
                        SnackbarCustom().createSnackBar(
                            '${model.title} excluída', Colors.green, context);
                      },
                      child: SubItemSaveWidget(
                        theme: store.client.theme,
                        subtarefa: model,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
