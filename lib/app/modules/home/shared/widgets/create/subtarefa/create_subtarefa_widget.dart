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
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

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
            color: store.client.theme
                ? darkThemeData(context).scaffoldBackgroundColor
                : lightThemeData(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Text(
                          store.clientCreate.subtarefaModelSaveTitle != ""
                              ? store.clientCreate.subtarefaModelSaveTitle
                              : 'Subtarefa',
                          style: const TextStyle(fontSize: 11),
                        ),
                        avatar: Icon(Icons.work,
                            color: store.clientCreate.subtarefaModelSaveTitle !=
                                        "" &&
                                    store.clientCreate
                                            .subtarefaModelSaveTitle !=
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
                      ),
                      store.client.theme,
                      context,
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                      store.client.theme,
                      context,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
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
                            store.client.theme,
                            context,
                          ),
                          child: Observer(
                            builder: (_) {
                              return store.clientCreate.imageUser == ""
                                  ? const Chip(
                                      label: Text('Equipe'),
                                      avatar: Icon(
                                        Icons.people,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : CircleAvatarWidget(
                                      url: store.clientCreate.imageUser,
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Observer(builder: (_) {
                    if (store.clientCreate.subtarefaTextSave == "") {
                      textSubtarefaController.text = '';
                    }
                    return TextFormField(
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
                        hintText: "Insira sua subtarefa",
                      ),
                    );
                  }),
                  if (store.clientCreate.subtarefas.isNotEmpty)
                    const SubtarefasWidget(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.94,
                      height: MediaQuery.of(context).size.height * 0.085,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            store.client.theme
                                ? darkThemeData(context).iconTheme.color
                                : lightThemeData(context).iconTheme.color,
                          ),
                        ),
                        onPressed: () {
                          store.clientCreate.isValidSubtarefa
                              ? store.clientCreate.setSubtarefas()
                              : DialogButtom().showDialog(
                                  ErrorsWidget(
                                    tarefa: false,
                                    theme: store.client.theme,
                                  ),
                                  store.client.theme,
                                  context,
                                );
                          FocusScope.of(context).unfocus();
                        },
                        icon: const Icon(Icons.add_circle, size: 18),
                        label: store.clientCreate.loadingSubtarefa
                            ? const CircularProgressWidget()
                            : const Text(
                                "INCLUIR",
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
