import 'package:flutter/material.dart';
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
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/simple_button_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class CardIntWidget extends StatefulWidget {
  final TarefaDioModel tarefaDioModel;
  final double constraint;
  const CardIntWidget({
    Key? key,
    required this.tarefaDioModel,
    required this.constraint,
  }) : super(key: key);

  @override
  State<CardIntWidget> createState() => _CardIntWidgetState();
}

class _CardIntWidgetState extends State<CardIntWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
          store.clientCreate.setTarefaUpdate(
            widget.tarefaDioModel,
          );
          DialogButtom().showDialogCreate(
              CreateWidget(
                constraint: widget.constraint,
              ),
              widget.constraint,
              context,
              store.getDioFase());
        } else {
          dialogDelete(
            widget.tarefaDioModel.texto,
            widget.tarefaDioModel,
            context,
          );
        }
      },
      child: PhysicalModel(
        color: Colors.transparent,
        child: PhysicalModel(
          color: Colors.transparent,
          child: Card(
            key: UniqueKey(),
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
                          color: ConvertIcon().convertColor(
                              widget.tarefaDioModel.etiqueta.color),
                          width: 15)),
                ),
                alignment: Alignment.centerLeft,
                child: ExpansionTile(
                  textColor: Colors.black,
                  title: HeaderWidget(
                    tarefa: widget.tarefaDioModel,
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
                              model: widget.tarefaDioModel,
                            ),
                            store.client.theme,
                            widget.constraint,
                            context,
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Icon(
                                  changeIconeAndColorTime(
                                      widget.tarefaDioModel.data)[1],
                                  color: changeIconeAndColorTime(
                                      widget.tarefaDioModel.data)[0],
                                ),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(widget.tarefaDioModel.data)
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
                              constraint: widget.constraint,
                              prioridadeSelection:
                                  store.client.prioridadeSelection,
                              setPrioridadeSelection:
                                  store.client.setPrioridadeSelection,
                              tarefaModel: widget.tarefaDioModel,
                              changePrioridadeList: store.changePrioridadeList,
                            ),
                            store.client.theme,
                            widget.constraint,
                            context,
                          ),
                          child: Icon(
                            Icons.flag,
                            color: ConvertIcon().convertColorFlaf(
                                widget.tarefaDioModel.prioridade),
                          ),
                        )
                      ],
                    ),
                  ),
                  children: [
                    Wrap(
                      children: [
                        BodyTextWidget(
                          tarefa: widget.tarefaDioModel,
                          theme: store.client.theme,
                          setSubtarefaModel: store.client.setSubtarefaModel,
                          subtarefaActionList: store.client.subtarefaActionList,
                        ),
                        ButtonActionWidget(
                          tarefa: widget.tarefaDioModel,
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
                function: store.deleteDioTasks,
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
}
