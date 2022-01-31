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
          return store.clientCreate.loading
              ? const CircularProgressIndicator()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4),
                  itemCount: store.clientCreate.subtarefas.length,
                  itemBuilder: (BuildContext context, int index) {
                    var model = store.clientCreate.subtarefas[index];
                    return Dismissible(
                      background: Container(color: Colors.red),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          store.clientCreate.setLoading(true);
                          store.clientCreate.users.removeWhere((element) =>
                              element.reference ==
                              store.clientCreate.subtarefas[index].user
                                  .reference);
                          store.clientCreate.subtarefas.removeWhere(
                            (e) =>
                                e.texto == model.texto &&
                                e.title == model.title &&
                                e.user.name == model.user.name,
                          );
                          store.clientCreate.setLoading(false);
                        });
                        SnackbarCustom().createSnackBar(
                            '${model.title} excluída', Colors.green, context);
                      },
                      child: SubItemSaveWidget(
                          theme: store.client.theme, subtarefa: model),
                    );
                  },
                );
        },
      ),
    );
  }
}
