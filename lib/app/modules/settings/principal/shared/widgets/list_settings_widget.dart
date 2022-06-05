import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/widgets/dialog_input_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/simple_button_widget.dart';

class ListSettingsWidget extends StatefulWidget {
  final double constraint;
  const ListSettingsWidget({Key? key, required this.constraint})
      : super(key: key);

  @override
  State<ListSettingsWidget> createState() => _ListSettingsWidgetState();
}

class _ListSettingsWidgetState extends State<ListSettingsWidget> {
  final PrincipalStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Observer(builder: (_) {
        return ListView.separated(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(4),
            itemCount: store.client.escolha.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              var linha = store.client.escolha[index];
              return GestureDetector(
                onDoubleTap: () {
                  store.client.setValueEscolha(linha);
                  DialogButtom().showDialog(
                    DialogInputWidget(
                      value: linha,
                      editar: store.edit,
                      constraint: widget.constraint,
                    ),
                    store.client.isSwitched,
                    widget.constraint,
                    context,
                  );
                  store.client.setEscolha(store.client.escolha);
                },
                child: Wrap(
                  children: [
                    Dismissible(
                      background: Container(
                        color: Colors.green,
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
                      secondaryBackground: Container(
                        color: Colors.red,
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
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          store.client.setValueEscolha(linha);
                          DialogButtom().showDialog(
                            DialogInputWidget(
                              value: linha,
                              editar: store.edit,
                              constraint: widget.constraint,
                            ),
                            store.client.isSwitched,
                            widget.constraint,
                            context,
                          );
                          store.client.setEscolha(store.client.escolha);
                        } else {
                          dialogDelete(linha, context);
                        }
                      },
                      child: ListTile(
                        title: Text(
                          store.client.label == 'Tempo'
                              ? linha.tempoName.toUpperCase()
                              : linha.toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: widget.constraint >=
                                      LarguraLayoutBuilder().telaPc
                                  ? 18
                                  : 14),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }

  dialogDelete(tarefa, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Excluir Tarefa.',
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 140, 82, 241)),
          ),
          content: const Text(
            'Tem certeza que deseja excluír a tarefa ?',
            maxLines: 1,
          ),
          actions: [
            SimpleButtonWidget(
              theme: store.client.isSwitched,
              buttonName: 'CANCELAR',
              popUp: true,
            ),
            SimpleButtonWidget(
              theme: store.client.isSwitched,
              buttonName: 'EXCLUIR',
              popUp: true,
              function: store.delete,
              dataFunction: tarefa,
              delete: true,
              scnack: true,
              msgSnack: 'Deletado com sucesso!',
            ),
          ],
        );
      },
    );
  }
}
