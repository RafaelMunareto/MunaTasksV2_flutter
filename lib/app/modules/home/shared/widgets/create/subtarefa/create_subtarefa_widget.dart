import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/actions_fase_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/button_save_create_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_user_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/subtarefas_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class CreateSubtarefaWidget extends StatefulWidget {
  final double constraint;
  const CreateSubtarefaWidget({
    Key? key,
    required this.constraint,
  }) : super(key: key);

  @override
  State<CreateSubtarefaWidget> createState() => _CreateSubtarefaWidgetState();
}

class _CreateSubtarefaWidgetState extends State<CreateSubtarefaWidget> {
  TextEditingController textSubtarefaController = TextEditingController();
  final HomeStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    textSubtarefaController.text = store.clientCreate.subtarefaTextSave;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: store.client.theme
                ? darkThemeData(context).scaffoldBackgroundColor
                : lightThemeData(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(4)),
        child: Wrap(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      store.clientCreate.subtarefaTextSave != ""
                          ? !store.clientCreate.editar
                              ? Container()
                              : MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: widget.constraint >=
                                            LarguraLayoutBuilder().telaPc
                                        ? Chip(
                                            label: const MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Text(
                                                'Novo',
                                                style: TextStyle(fontSize: 11),
                                              ),
                                            ),
                                            avatar: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Icon(
                                                Icons.add_circle_sharp,
                                                color: store.clientCreate
                                                                .subtarefaModelSaveTitle !=
                                                            "" &&
                                                        store.clientCreate
                                                                .subtarefaModelSaveTitle !=
                                                            "Subtarefa"
                                                    ? Colors.blue
                                                    : Colors.grey,
                                              ),
                                            ),
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child:
                                                  Icon(Icons.add_circle_sharp),
                                            ),
                                          ),
                                    onTap: () {
                                      store.clientCreate.setSubtarefaTextSave(
                                          textSubtarefaController.text);
                                      store.clientCreate.cleanSubtarefa();
                                      store.clientCreate.setEditar(false);
                                    },
                                  ),
                                )
                          : Container(),
                      GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: widget.constraint >=
                                    LarguraLayoutBuilder().telaPc
                                ? Chip(
                                    label: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Text(
                                        store.clientCreate
                                                    .subtarefaModelSaveTitle !=
                                                ""
                                            ? store.clientCreate
                                                .subtarefaModelSaveTitle
                                            : 'Subtarefa',
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ),
                                    avatar: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Icon(
                                        Icons.work,
                                        color: store.clientCreate
                                                        .subtarefaModelSaveTitle !=
                                                    "" &&
                                                store.clientCreate
                                                        .subtarefaModelSaveTitle !=
                                                    "Subtarefa"
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ),
                                  )
                                : MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(
                                      Icons.work,
                                      color: store.clientCreate
                                                      .subtarefaModelSaveTitle !=
                                                  "" &&
                                              store.clientCreate
                                                      .subtarefaModelSaveTitle !=
                                                  "Subtarefa"
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                          ),
                          onTap: () {
                            DialogButtom().showDialog(
                              CreateSubtarefaInsertWidget(
                                subtarefaInserSelection:
                                    store.clientCreate.subtarefaModelSaveTitle,
                                setSubtarefaSelection:
                                    store.clientCreate.setSubtarefaInsertCreate,
                              ),
                              store.client.theme,
                              widget.constraint,
                              context,
                            );
                            store.clientCreate.setSubtarefaTextSave(
                                textSubtarefaController.text);
                          }),
                      GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: widget.constraint >=
                                    LarguraLayoutBuilder().telaPc
                                ? Chip(
                                    backgroundColor: ConvertIcon()
                                        .colorStatus(store.clientCreate.fase),
                                    label: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Text(
                                        ConvertIcon().nameStatus(
                                            store.clientCreate.fase),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ConvertIcon()
                                                .colorStatusDark(
                                                    store.clientCreate.fase)),
                                      ),
                                    ),
                                    avatar: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Icon(
                                        ConvertIcon().iconStatus(
                                            store.clientCreate.fase),
                                        color: ConvertIcon().colorStatusDark(
                                            store.clientCreate.fase),
                                      ),
                                    ),
                                  )
                                : MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(
                                      ConvertIcon()
                                          .iconStatus(store.clientCreate.fase),
                                      color: ConvertIcon().colorStatusDark(
                                          store.clientCreate.fase),
                                    ),
                                  ),
                          ),
                          onTap: () {
                            store.clientCreate.setSubtarefaTextSave(
                                textSubtarefaController.text);
                            DialogButtom().showDialog(
                              ActionsFaseWidget(
                                faseList: store.client.fase,
                                setActionsFase: store.clientCreate.setFase,
                                constraint: widget.constraint,
                              ),
                              store.client.theme,
                              widget.constraint,
                              context,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  store.clientCreate.setSubtarefaTextSave(
                                      textSubtarefaController.text);
                                  DialogButtom().showDialog(
                                    CreateUserSubtarefaWidget(
                                      userLista: store.client.perfis,
                                      setCreateImageUser:
                                          store.clientCreate.setCreateImageUser,
                                      setUserCreateSelection: store
                                          .clientCreate.setUserCreateSelection,
                                    ),
                                    store.client.theme,
                                    widget.constraint,
                                    context,
                                  );
                                },
                                child: Observer(
                                  builder: (_) {
                                    return store.clientCreate.imageUser == ""
                                        ? widget.constraint >=
                                                LarguraLayoutBuilder().telaPc
                                            ? const Chip(
                                                label: MouseRegion(
                                                    cursor: SystemMouseCursors
                                                        .click,
                                                    child: AutoSizeText(
                                                      'Equipe',
                                                      maxLines: 1,
                                                    )),
                                                avatar: MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: Icon(
                                                    Icons.people,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              )
                                            : const MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: Icon(
                                                  Icons.people,
                                                  color: Colors.grey,
                                                ),
                                              )
                                        : MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: CircleAvatarWidget(
                                              nameUser: store.clientCreate
                                                  .createUser.name.name,
                                              url: store.clientCreate.imageUser,
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 13,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Observer(builder: (_) {
                        if (store.clientCreate.editar) {
                          textSubtarefaController.text =
                              store.clientCreate.subtarefaTextSave;
                        }
                        return TextField(
                          autocorrect: true,
                          autofocus: false,
                          controller: textSubtarefaController,
                          minLines: 3,
                          maxLines: 20,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                child: const Icon(Icons.replay),
                                onTap: () {
                                  setState(() {
                                    store.clientCreate.setSubtarefaTextSave('');
                                    textSubtarefaController.text = '';
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  });
                                }),
                            hintText: "Insira sua subtarefa",
                          ),
                        );
                      }),
                      if (store.clientCreate.subtarefas.isNotEmpty)
                        const SubtarefasWidget(),
                    ],
                  ),
                ),
              ],
            ),
            ButtonSaveCreateSubtarefaWidget(
              texto: textSubtarefaController,
              constraint: widget.constraint,
            ),
          ],
        ),
      );
    });
  }
}
