import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/users_selection_widget.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class CreateWidget extends StatefulWidget {
  final TarefaModel tarefaModel;
  final AnimationController controller;
  final Function saveSetEtiqueta;
  final dynamic etiquetaList;
  final dynamic userList;
  final EtiquetaModel etiquetaModel;
  final Function setIdStaff;
  final Function setIdReferenceStaff;
  final List individualChip;
  final List saveIdStaff;
  final String tarefaTextSave;
  final Function setTarefaTextSave;
  const CreateWidget(
      {Key? key,
      required this.controller,
      required this.tarefaModel,
      required this.saveSetEtiqueta,
      required this.etiquetaList,
      required this.etiquetaModel,
      required this.userList,
      required this.setIdStaff,
      required this.individualChip,
      required this.setIdReferenceStaff,
      required this.saveIdStaff,
      required this.tarefaTextSave,
      required this.setTarefaTextSave})
      : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget>
    with SingleTickerProviderStateMixin {
  late Animation altura;
  late Animation<double> opacidade;

  @override
  Widget build(BuildContext context) {
    etiquetas() {
      showDialog(
        useSafeArea: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Etiquetas'),
            content: RadioEtiquetasFilterWidget(
              etiquetaList: widget.etiquetaList,
              create: true,
              setEtiquetaSave: widget.saveSetEtiqueta,
            ),
          );
        },
      );
    }

    users() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Modular.to.pop();
                  setState(() {
                    widget.saveIdStaff;
                  });
                },
                child: const Text('OK'),
              ),
            ],
            title: const Text('Responsáveis'),
            content: UsersSelectionWidget(
              userList: widget.userList,
              setSaveIdStaff: widget.setIdStaff,
              individualChip: widget.individualChip,
              saveIdStaff: widget.saveIdStaff,
              setIdReferenceStaff: widget.setIdReferenceStaff,
            ),
          );
        },
      );
    }

    altura =
        Tween<double>(begin: 0, end: MediaQuery.of(context).size.height * 0.3)
            .animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.1, 0.7),
      ),
    );

    opacidade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.1, 0.7),
      ),
    );

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (ctx, ch) {
        return SizedBox(
          child: FadeTransition(
            opacity: opacidade,
            child: Card(
              shape: Border(
                top: BorderSide(
                    color: ConvertIcon()
                            .convertColor(widget.etiquetaModel.color) ??
                        Colors.grey,
                    width: 5),
              ),
              elevation: 8,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text(widget.etiquetaModel.icon != null
                              ? widget.etiquetaModel.etiqueta
                              : 'Etiqueta'),
                          avatar: Icon(
                            widget.etiquetaModel.icon != null
                                ? IconData(widget.etiquetaModel.icon ?? 0,
                                    fontFamily: 'MaterialIcons')
                                : Icons.bookmark,
                            color: ConvertIcon()
                                .convertColor(widget.etiquetaModel.color),
                          ),
                        ),
                      ),
                      onTap: () => etiquetas(),
                    ),
                    Wrap(
                      children: [
                        if (widget.saveIdStaff.isEmpty)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.saveIdStaff;
                                widget.userList;
                              });
                              users();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Chip(
                                label: Text('Equipe'),
                                avatar: Icon(
                                  Icons.people,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        for (var i = 0; i < widget.saveIdStaff.length; i++)
                          GestureDetector(
                            onTap: () => users(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                              child: GestureDetector(
                                onTap: () => users(),
                                child: CircleAvatarWidget(
                                    key: Key(widget.saveIdStaff[i].reference
                                        .toString()),
                                    url: widget.saveIdStaff[i].urlImage
                                        .toString()),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autocorrect: true,
                        initialValue: widget.tarefaTextSave,
                        onChanged: (value) => widget.setTarefaTextSave(value),
                        minLines: 1,
                        maxLines: 20,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                child: const Icon(Icons.close_outlined),
                                onTap: () {
                                  setState(() {
                                    widget.setTarefaTextSave('');
                                  });
                                }),
                            hintText: "Insira sua tarefa"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          height: altura.value,
        );
      },
    );
  }
}
