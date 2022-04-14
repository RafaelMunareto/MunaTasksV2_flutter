import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/modules/settings/principal/widgets/dialog_input_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class ListSettingsWidget extends StatefulWidget {
  const ListSettingsWidget({Key? key}) : super(key: key);

  @override
  State<ListSettingsWidget> createState() => _ListSettingsWidgetState();
}

class _ListSettingsWidgetState extends State<ListSettingsWidget> {
  final PrincipalStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Column(
        children: [
          Observer(builder: (_) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4),
                  itemCount: store.escolha.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var linha = store.escolha[index];
                    return Wrap(
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
                              DialogButtom().showDialog(
                                DialogInputWidget(
                                  value: linha,
                                  editar: store.edit,
                                ),
                                context,
                              );
                              store.setEscolha(store.escolha);
                            } else {
                              dialogDelete(linha, context);
                            }
                          },
                          child: ListTile(
                            title: Text(
                              store.label == 'Tempo'
                                  ? linha.tempoName.toUpperCase()
                                  : linha.toString().toUpperCase(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }),
        ],
      ),
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
          content: const Text('Tem certeza que deseja excluír a tarefa ?'),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 140, 82, 241)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 140, 82, 241),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                store.setEscolha(store.escolha);
                Navigator.pop(context);
              },
              child: const Text(
                'CANCELAR',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 140, 82, 241)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 140, 82, 241),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                store.delete(tarefa);
                SnackbarCustom().createSnackBar(
                    'Deletado com sucesso!', Colors.green, context);
                Modular.to.pop();
              },
              child: const Text(
                'EXCLUIR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
