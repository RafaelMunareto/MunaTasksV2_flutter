import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/actions_fase_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/errors_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_insert_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_user_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefas_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

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
    _subtarefa() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Subtarefa'),
            content: CreateSubtarefaInsertWidget(
                subtarefaInserSelection:
                    store.clientCreate.subtarefaModelSaveTitle,
                setSubtarefaSelection:
                    store.clientCreate.setSubtarefaInsertCreate,
                subtarefaList: store.clientCreate.subtarefaInsertList),
          );
        },
      );
    }

    _actions() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fase'),
            content: ActionsFaseWidget(
              faseList: store.clientCreate.faseList,
              setActionsFase: store.clientCreate.setFase,
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
            title: const Text('Responsável'),
            content: CreateUserSubtarefaWidget(
              userLista: store.client.userList,
              setCreateImageUser: store.clientCreate.setCreateImageUser,
              setUserCreateSelection: store.clientCreate.setUserCreateSelection,
            ),
          );
        },
      );
    }

    errors() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erros'),
            content: ErrorsWidget(
              erroTexto: store.clientCreate.validTextoSubtarefa(),
              erroTitle: store.clientCreate.validTitleSubtarefa(),
              erroUser: store.clientCreate.validaUserSubtarefa(),
            ),
          );
        },
      );
    }

    return Observer(builder: (_) {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: store.client.theme ? Colors.black38 : Colors.black12,
            borderRadius: BorderRadius.circular(4)),
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                  backgroundColor:
                      store.client.theme ? Colors.black38 : Colors.grey[100],
                  label: Text(store.clientCreate.subtarefaModelSaveTitle != ""
                      ? store.clientCreate.subtarefaModelSaveTitle
                      : 'Subtarefa'),
                  avatar: Icon(Icons.work,
                      color: store.clientCreate.subtarefaModelSaveTitle != "" &&
                              store.clientCreate.subtarefaModelSaveTitle !=
                                  "Subtarefa"
                          ? Colors.blue
                          : Colors.grey),
                ),
              ),
              onTap: () => _subtarefa(),
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
                          .colorStatusDark(store.clientCreate.fase)),
                ),
              ),
              onTap: () => _actions(),
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () => users(),
                  child: store.clientCreate.imageUser == ""
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18, 8, 0),
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
                              url: store.clientCreate.imageUser),
                        ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Padding(
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
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                    child: ElevatedButton.icon(
                      onPressed: () => store.clientCreate.isValidSubtarefa
                          ? store.clientCreate.setSubtarefas()
                          : errors(),
                      icon: const Icon(Icons.add, size: 18),
                      label: store.clientCreate.loading
                          ? const CircularProgressIndicator()
                          : const Text("INCLUIR"),
                    ),
                  )
                ],
              ),
            ),
            if (store.clientCreate.subtarefas.isNotEmpty)
              const SubtarefasWidget(),
          ],
        ),
      );
    });
  }
}
