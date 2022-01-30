import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/prioridade_selection_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/users_selection_widget.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class CreateWidget extends StatefulWidget {
  final AnimationController controller;
  final List individualChip;
  final dynamic etiquetaList;
  final dynamic prioridadeList;
  final dynamic userList;
  final dynamic faseList;
  final EtiquetaModel tarefaModelSaveEtiqueta;
  final String tarefaModelSaveTexto;
  final dynamic tarefaModelData;
  final int tarefaModelPrioritario;
  final String subtarefaModelSaveTitle;
  final String fase;
  final Function setFase;
  final Function setIdStaff;
  final Function setIdReferenceStaff;
  final Function setTarefaTextSave;
  final Function setTarefaDateSave;
  final Function setPrioridadeSaveSelection;
  final Function setSubtarefaInsertCreate;
  final Function setTarefaEtiquetaSave;
  final dynamic subtarefaList;
  final dynamic theme;
  final List<UserModel> users;

  const CreateWidget({
    Key? key,
    required this.controller,
    required this.individualChip,
    required this.etiquetaList,
    required this.prioridadeList,
    required this.userList,
    required this.faseList,
    required this.tarefaModelSaveEtiqueta,
    required this.tarefaModelSaveTexto,
    required this.tarefaModelData,
    required this.subtarefaModelSaveTitle,
    required this.fase,
    required this.setFase,
    required this.tarefaModelPrioritario,
    required this.setIdStaff,
    required this.setIdReferenceStaff,
    required this.setTarefaTextSave,
    required this.setTarefaDateSave,
    required this.setPrioridadeSaveSelection,
    required this.setSubtarefaInsertCreate,
    required this.setTarefaEtiquetaSave,
    required this.subtarefaList,
    required this.theme,
    required this.users,
  }) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget>
    with SingleTickerProviderStateMixin {
  late Animation altura;
  late Animation<double> opacidade;
  TextEditingController textController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      helpText: 'Selecione uma data',
    );
    if (newDate != null) {
      var dateFormat = DateFormat('dd/MM/yyyy').format(newDate);
      setState(() {
        dateController.text = dateFormat;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    textController.text = widget.tarefaModelSaveTexto;
  }

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
              setEtiquetaSave: widget.setTarefaEtiquetaSave,
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
                    widget.users;
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
              saveIdStaff: widget.users,
              setIdReferenceStaff: widget.setIdReferenceStaff,
            ),
          );
        },
      );
    }

    prioridade() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Prioridade'),
            content: PrioridadeSelectionWidget(
              create: true,
              prioridadeSelection: widget.tarefaModelPrioritario,
              prioridadeList: widget.prioridadeList,
              setPrioridadeSelection: widget.setPrioridadeSaveSelection,
            ),
          );
        },
      );
    }

    altura =
        Tween<double>(begin: 0, end: MediaQuery.of(context).size.height * 0.5)
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
        if (widget.controller.status == AnimationStatus.dismissed) {
          textController.text = '';
        }
        return SizedBox(
          child: FadeTransition(
            opacity: opacidade,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Card(
                shape: Border(
                  top: BorderSide(
                      color: ConvertIcon().convertColor(
                              widget.tarefaModelSaveEtiqueta.color) ??
                          Colors.grey,
                      width: 5),
                ),
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
                            label: Text(
                                widget.tarefaModelSaveEtiqueta.icon != null
                                    ? widget.tarefaModelSaveEtiqueta.etiqueta
                                    : 'Etiqueta'),
                            avatar: Icon(
                              widget.tarefaModelSaveEtiqueta.icon != null
                                  ? IconData(
                                      widget.tarefaModelSaveEtiqueta.icon ?? 0,
                                      fontFamily: 'MaterialIcons')
                                  : Icons.bookmark,
                              color: ConvertIcon().convertColor(
                                  widget.tarefaModelSaveEtiqueta.color),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            etiquetas();
                          });
                        },
                      ),
                      Wrap(
                        children: [
                          if (widget.users.isEmpty)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.users;
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
                          if (widget.users.isNotEmpty)
                            for (var i = 0; i < widget.users.length; i++)
                              GestureDetector(
                                onTap: () => users(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  child: GestureDetector(
                                    onTap: () => users(),
                                    child: CircleAvatarWidget(
                                        key: Key(widget.users[i].reference
                                            .toString()),
                                        url: widget.users[i].urlImage
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
                          autofocus: false,
                          controller: textController,
                          onChanged: (value) => widget.setTarefaTextSave(value),
                          minLines: 3,
                          maxLines: 20,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  child: const Icon(Icons.close_outlined),
                                  onTap: () {
                                    setState(() {
                                      widget.setTarefaTextSave('');
                                      textController.text = '';
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    });
                                  }),
                              hintText: "Insira sua tarefa"),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                autofocus: false,
                                controller: dateController,
                                onChanged: (value) =>
                                    widget.setTarefaDateSave(value),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(0, 14, 0, 0),
                                  prefixIcon: InkWell(
                                    child: const Icon(Icons.calendar_today),
                                    onTap: () => _selectDate(),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => prioridade(),
                              child: Padding(
                                key: UniqueKey(),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 24, 12),
                                child: Icon(
                                  widget.tarefaModelPrioritario == 0
                                      ? Icons.flag_outlined
                                      : Icons.flag,
                                  color: ConvertIcon().convertColorFlaf(
                                    widget.tarefaModelPrioritario,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Wrap(
                          children: [
                            CreateSubtarefaWidget(
                              subtarefaList: widget.subtarefaList,
                              subtarefaInserSelection:
                                  widget.subtarefaModelSaveTitle,
                              setSubtarefaSelection:
                                  widget.setSubtarefaInsertCreate,
                              theme: widget.theme,
                              fase: widget.fase,
                              setFase: widget.setFase,
                              faseList: widget.faseList,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
