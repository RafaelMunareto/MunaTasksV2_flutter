import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/sub_item_save_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class SubtarefasWidget extends StatefulWidget {
  final TextEditingController controller;
  const SubtarefasWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<SubtarefasWidget> createState() => _SubtarefasWidgetState();
}

class _SubtarefasWidgetState extends State<SubtarefasWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.24,
      child: SingleChildScrollView(
        child: Observer(
          builder: (_) {
            return store.clientCreate.loadingSubtarefa
                ? const CircularProgressWidget()
                : ReorderableListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(4),
                    itemCount: store.clientCreate.subtarefas.length,
                    itemBuilder: (BuildContext context, int index) {
                      var model = store.clientCreate.subtarefas[index];
                      return GestureDetector(
                        key: ValueKey(index),
                        onDoubleTap: () {
                          store.clientCreate.setEditar(true);
                          store.clientCreate.setSubtarefaUpdate(model);
                          store.clientCreate.setSubtarefasUpdate(
                              store.clientCreate.subtarefas);
                          widget.controller.text = model.texto;
                        },
                        child: Dismissible(
                          background: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Editar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          secondaryBackground: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                            if (direction == DismissDirection.startToEnd) {
                              store.clientCreate.setEditar(true);
                              store.clientCreate.setSubtarefaUpdate(model);
                              store.clientCreate.setSubtarefasUpdate(
                                  store.clientCreate.subtarefas);
                            } else {
                              store.clientCreate.removeDismissSubtarefa(model);
                              SnackbarCustom().createSnackBar(
                                  '${model.title} excluída',
                                  Colors.green,
                                  context);
                            }
                          },
                          child: SubItemSaveWidget(
                            theme: store.client.theme,
                            subtarefa: model,
                          ),
                        ),
                      );
                    },
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final dynamic item =
                            store.clientCreate.subtarefas.removeAt(oldIndex);
                        store.clientCreate.subtarefas.insert(newIndex, item);
                      });
                    });
          },
        ),
      ),
    );
  }
}
