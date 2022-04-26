import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_text_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/button_action_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/create_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/header_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/prioridade_selection_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/retard_action_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/simple_button_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

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
          return SizedBox(
            width: 200,
            height: 200,
            child: AlertDialog(
              key: Key(tarefa.id!),
              title: Text(
                'Excluir Tarefa.',
                style: TextStyle(
                    color: store.client.theme
                        ? darkThemeData(context).primaryColor
                        : lightThemeData(context).primaryColor),
              ),
              content: const Text('Tem certeza que deseja excluír a tarefa ?'),
              actions: [
                SimpleButtonWidget(
                  theme: store.client.theme,
                  buttonName: 'CANCELAR',
                  popUp: true,
                ),
                SimpleButtonWidget(
                  theme: store.client.theme,
                  buttonName: 'EXCLUIR',
                  popUp: true,
                  function: store.deleteTasks,
                  dataFunction: tarefa,
                  scnack: true,
                  msgSnack: 'Deletado com sucesso!',
                ),
              ],
            ),
          );
        },
      );
    }

    card(linha, constraint) {
      return PhysicalModel(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: PhysicalModel(
            color: Colors.transparent,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: ConvertIcon()
                                .convertColor(linha.etiqueta.color),
                            width: 15)),
                  ),
                  alignment: Alignment.centerLeft,
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
                              store.client.theme,
                              constraint,
                              context,
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    changeIconeAndColorTime(linha.data)[1],
                                    color:
                                        changeIconeAndColorTime(linha.data)[0],
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
                                changePrioridadeList:
                                    store.changePrioridadeList,
                              ),
                              store.client.theme,
                              constraint,
                              context,
                            ),
                            child: Icon(
                              Icons.flag,
                              color: ConvertIcon()
                                  .convertColorFlaf(linha.prioridade),
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
                            setSubtarefaModel: store.client.setSubtarefaModel,
                            subtarefaActionList:
                                store.client.subtarefaActionList,
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
          ),
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: store.client.theme
                    ? darkThemeData(context).shadowColor.withOpacity(0.2)
                    : lightThemeData(context).shadowColor.withOpacity(0.2),
              ),
              BoxShadow(
                color: store.client.theme
                    ? darkThemeData(context).scaffoldBackgroundColor
                    : lightThemeData(context).scaffoldBackgroundColor,
                spreadRadius: -3.0,
                blurRadius: 4.0,
              ),
            ],
          ),
          child: LayoutBuilder(builder: (context, constraint) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Observer(builder: (_) {
                  return store.client.loadingTasks
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: const Center(
                            child: CircularProgressWidget(),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              key: UniqueKey(),
                              flex: 1,
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Wrap(
                                  children: [
                                    Wrap(
                                      children: [
                                        Observer(
                                          builder: (_) {
                                            return ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              controller: ScrollController(),
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.all(4),
                                              itemCount:
                                                  store.client.taskDio.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                TarefaDioModel linha =
                                                    store.client.taskDio[index];
                                                return Wrap(
                                                  key: UniqueKey(),
                                                  children: [
                                                    Dismissible(
                                                      background: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          color: Colors.green,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            child: Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  'Editar',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      secondaryBackground:
                                                          Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          color: Colors.red,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: const [
                                                                Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  'Excluir',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      key: UniqueKey(),
                                                      onDismissed: (direction) {
                                                        if (direction ==
                                                            DismissDirection
                                                                .startToEnd) {
                                                          store.clientCreate
                                                              .setTarefaUpdate(
                                                            linha,
                                                          );
                                                          DialogButtom()
                                                              .showDialogCreate(
                                                            CreateWidget(
                                                              constraint:
                                                                  constraint
                                                                      .maxWidth,
                                                            ),
                                                            constraint.maxWidth,
                                                            context,
                                                          );
                                                        } else {
                                                          setState(() {
                                                            dialogDelete(
                                                              linha.texto,
                                                              linha,
                                                              context,
                                                            );
                                                          });
                                                        }
                                                      },
                                                      child: card(linha,
                                                          constraint.maxWidth),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                }));
          }),
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
