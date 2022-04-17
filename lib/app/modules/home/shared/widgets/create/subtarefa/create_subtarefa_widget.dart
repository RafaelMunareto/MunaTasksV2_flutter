import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/actions_fase_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_user_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/subtarefas_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

class CreateSubtarefaWidget extends StatefulWidget {
  const CreateSubtarefaWidget({
    Key? key,
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
            color: store.client.theme ? Colors.black38 : Colors.black12,
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: kIsWeb || Platform.isWindows
              ? const EdgeInsets.all(8.0)
              : const EdgeInsets.all(0),
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Chip(
                    backgroundColor:
                        store.client.theme ? Colors.black38 : Colors.grey[100],
                    label: Text(store.clientCreate.subtarefaModelSaveTitle != ""
                        ? store.clientCreate.subtarefaModelSaveTitle
                        : 'Subtarefa'),
                    avatar: Icon(Icons.work,
                        color: store.clientCreate.subtarefaModelSaveTitle !=
                                    "" &&
                                store.clientCreate.subtarefaModelSaveTitle !=
                                    "Subtarefa"
                            ? Colors.blue
                            : Colors.grey),
                  ),
                ),
                onTap: () => DialogButtom().showDialog(
                    CreateSubtarefaInsertWidget(
                        subtarefaInserSelection:
                            store.clientCreate.subtarefaModelSaveTitle,
                        setSubtarefaSelection:
                            store.clientCreate.setSubtarefaInsertCreate,
                        subtarefaList: const []),
                    context),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Chip(
                    backgroundColor:
                        ConvertIcon().colorStatus(store.clientCreate.fase),
                    label: Text(
                      ConvertIcon().nameStatus(store.clientCreate.fase),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ConvertIcon()
                              .colorStatusDark(store.clientCreate.fase)),
                    ),
                    avatar: Icon(
                      ConvertIcon().iconStatus(store.clientCreate.fase),
                      color: ConvertIcon()
                          .colorStatusDark(store.clientCreate.fase),
                    ),
                  ),
                ),
                onTap: () => DialogButtom().showDialog(
                    ActionsFaseWidget(
                      faseList: store.client.fase,
                      setActionsFase: store.clientCreate.setFase,
                    ),
                    context),
              ),
              Wrap(
                children: [
                  GestureDetector(
                    onTap: () => DialogButtom().showDialog(
                        CreateUserSubtarefaWidget(
                          userLista: store.client.perfis,
                          setCreateImageUser:
                              store.clientCreate.setCreateImageUser,
                          setUserCreateSelection:
                              store.clientCreate.setUserCreateSelection,
                        ),
                        context),
                    child: Observer(
                      builder: (_) {
                        return store.clientCreate.imageUser == ""
                            ? Padding(
                                padding: kIsWeb || Platform.isWindows
                                    ? const EdgeInsets.fromLTRB(0, 4, 4, 16)
                                    : const EdgeInsets.fromLTRB(0, 12, 8, 16),
                                child: Icon(
                                  Icons.people,
                                  color: store.client.theme
                                      ? Colors.grey[200]
                                      : Colors.grey[600],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                                child: CircleAvatarWidget(
                                  url: store.clientCreate.imageUser,
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Observer(builder: (_) {
                    if (store.clientCreate.subtarefaTextSave == "") {
                      textSubtarefaController.text = '';
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                      child: TextFormField(
                        autocorrect: true,
                        autofocus: false,
                        controller: textSubtarefaController,
                        onChanged: (value) =>
                            store.clientCreate.setSubtarefaTextSave(value),
                        minLines: 3,
                        maxLines: 20,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                child: const Icon(Icons.close_outlined),
                                onTap: () {
                                  setState(() {
                                    store.clientCreate.setSubtarefaTextSave('');
                                    textSubtarefaController.text = '';
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  });
                                }),
                            hintText: "Insira sua subtarefa"),
                      ),
                    );
                  })
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    Padding(
                      padding: kIsWeb || Platform.isWindows
                          ? const EdgeInsets.fromLTRB(4, 8, 4, 8)
                          : const EdgeInsets.fromLTRB(4, 0, 4, 4),
                      child: store.clientCreate.loadingSubtarefa
                          ? const CircularProgressIndicator()
                          : OutlinedButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: store.client.theme
                                    ? Colors.black38
                                    : Colors.grey[100],
                              ),
                              onPressed: () {
                                store.clientCreate.isValidSubtarefa
                                    ? store.clientCreate.setSubtarefas()
                                    : DialogButtom().showDialog(
                                        const ErrorsWidget(
                                          tarefa: false,
                                        ),
                                        context);
                                FocusScope.of(context).unfocus();
                              },
                              icon: const Icon(Icons.add_circle, size: 18),
                              label: const Text(
                                "INCLUIR",
                              ),
                            ),
                    )
                  ],
                ),
              ),
              if (store.clientCreate.subtarefas.isNotEmpty)
                const SubtarefasWidget(),
            ],
          ),
        ),
      );
    });
  }
}
