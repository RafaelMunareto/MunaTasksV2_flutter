import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_text_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/button_action_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/header_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/prioridade_selection_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/retard_action_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    dialogDelete(String message, TarefaDioModel tarefa, context) {
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
                onPressed: () => Navigator.pop(context),
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
                  Modular.to.pop();
                  store.deleteDioTasks(tarefa);
                  SnackbarCustom().createSnackBar(
                      'Deletado com sucesso!', Colors.green, context);
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

    card(linha) {
      return PhysicalModel(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: PhysicalModel(
            color: Colors.transparent,
            elevation: 8,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: ConvertIcon().convertColor(linha.etiqueta.color),
                    width: 2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ExpansionTile(
                key: UniqueKey(),
                textColor: Colors.black,
                title: HeaderWidget(
                  tarefa: linha,
                  theme: store.client.theme,
                ),
                subtitle: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => DialogButtom().showDialog(
                            RetardActionWidget(
                              retardSelection: store.client.retardSelection,
                              setRetardSelection:
                                  store.client.setRetardSelection,
                              updateDate: store.updateDate,
                              model: linha,
                            ),
                            context),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                changeIconeAndColorTime(linha.data)[1],
                                color: changeIconeAndColorTime(linha.data)[0],
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(linha.data)
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: store.client.theme
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => DialogButtom().showDialog(
                            PrioridadeSelectionWidget(
                              prioridadeSelection:
                                  store.client.prioridadeSelection,
                              setPrioridadeSelection:
                                  store.client.setPrioridadeSelection,
                              tarefaModel: linha,
                              changePrioridadeList: store.changePrioridadeList,
                            ),
                            context),
                        child: Icon(
                          Icons.flag,
                          color:
                              ConvertIcon().convertColorFlaf(linha.prioridade),
                        ),
                      )
                    ],
                  ),
                ),
                children: [
                  Wrap(
                    children: [
                      BodyTextWidget(
                        tarefa: linha,
                        theme: store.client.theme,
                        changeSubtarefaModelAction: store.changeSubtarefaAction,
                        setSubtarefaModel: store.client.setSubtarefaModel,
                        subtarefaActionList: store.client.subtarefaActionList,
                      ),
                      ButtonActionWidget(
                        tarefa: linha,
                        navigate: store.client.navigateBarSelection,
                        save: store.save,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 54),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.63,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              Observer(
                builder: (_) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(4),
                    itemCount: store.client.taskDio.length,
                    itemBuilder: (BuildContext context, int index) {
                      var linha = store.client.taskDio[index];
                      return Wrap(
                        children: [
                          Dismissible(
                            background: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
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
                            ),
                            secondaryBackground: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
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
                            ),
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                setState(() {
                                  store.clientCreate.setTarefaUpdate(linha);
                                  store.client.setExpand(!store.client.expand);
                                });
                              } else {
                                setState(() {
                                  dialogDelete(linha.texto, linha, context);
                                });
                              }
                            },
                            child: card(linha),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeIconeAndColorTime(date) {
    DateTime now = DateTime.now();
    if (date.isAfter(now)) {
      return [Colors.blue, Icons.timelapse_sharp];
    } else if (date.day == now.day) {
      return [Colors.amber, Icons.alarm];
    } else {
      return [Colors.red, Icons.history];
    }
  }
}
