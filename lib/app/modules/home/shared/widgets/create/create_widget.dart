import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/button_header_create_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/button_save_create_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/subtarefas_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/text_save_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/text_save_widget.dart';
import 'package:munatasks2/app/shared/components/logo_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class CreateWidget extends StatefulWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget> {
  TextEditingController textController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController textSubtarefaController = TextEditingController();
  final HomeStore store = Modular.get();
  @override
  void initState() {
    super.initState();
    textSubtarefaController.text = store.clientCreate.subtarefaTextSave;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Observer(
        builder: (_) {
          return Scaffold(
            backgroundColor: store.client.theme
                ? darkThemeData(context).scaffoldBackgroundColor
                : lightThemeData(context).scaffoldBackgroundColor,
            body: SizedBox(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              store.client.setTodos();
                              Modular.to.pop();
                            },
                            child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Icon(
                                  Icons.close_rounded,
                                  color: store.client.theme
                                      ? Colors.white
                                      : Colors.black,
                                  size: 28,
                                )),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: store.client.theme
                              ? darkThemeData(context).scaffoldBackgroundColor
                              : lightThemeData(context).scaffoldBackgroundColor,
                          child: store.clientCreate.loadingSubtarefa
                              ? LogoWidget(
                                  constraint: constraint.maxWidth,
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 18),
                                        child: Wrap(
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ButtonHeaderCreateWidget(
                                                    textSubtarefaController:
                                                        textSubtarefaController,
                                                    constraint:
                                                        constraint.maxWidth,
                                                    tipo: 0,
                                                  ),
                                                  ButtonHeaderCreateWidget(
                                                    textSubtarefaController:
                                                        textSubtarefaController,
                                                    constraint:
                                                        constraint.maxWidth,
                                                    tipo: 1,
                                                  ),
                                                  ButtonHeaderCreateWidget(
                                                    textSubtarefaController:
                                                        textSubtarefaController,
                                                    constraint:
                                                        constraint.maxWidth,
                                                    tipo: 2,
                                                  ),
                                                  ButtonHeaderCreateWidget(
                                                    textSubtarefaController:
                                                        textSubtarefaController,
                                                    constraint:
                                                        constraint.maxWidth,
                                                    tipo: 4,
                                                    dateController:
                                                        dateController,
                                                  ),
                                                  ButtonHeaderCreateWidget(
                                                    textSubtarefaController:
                                                        textSubtarefaController,
                                                    constraint:
                                                        constraint.maxWidth,
                                                    tipo: 3,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextSaveWidget(
                                              controller: textController,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      4, 12, 2, 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ButtonHeaderCreateWidget(
                                                    textSubtarefaController:
                                                        textSubtarefaController,
                                                    constraint:
                                                        constraint.maxWidth,
                                                    tipo: 5,
                                                  ),
                                                  ButtonHeaderCreateWidget(
                                                    constraint:
                                                        constraint.maxWidth,
                                                    textSubtarefaController:
                                                        textSubtarefaController,
                                                    tipo: 6,
                                                  ),
                                                  ButtonHeaderCreateWidget(
                                                    constraint:
                                                        constraint.maxWidth,
                                                    textSubtarefaController:
                                                        textSubtarefaController,
                                                    tipo: 7,
                                                    dateController:
                                                        dateController,
                                                  ),
                                                  ButtonHeaderCreateWidget(
                                                    constraint:
                                                        constraint.maxWidth,
                                                    textSubtarefaController:
                                                        textSubtarefaController,
                                                    tipo: 8,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextSaveSubtarefaWidget(
                                              controller:
                                                  textSubtarefaController,
                                            ),
                                            ButtonSaveCreateWidget(
                                              texto: textController,
                                              textoSubtarefa:
                                                  textSubtarefaController,
                                              constraint: constraint.maxWidth,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 7,
                                      child: SubtarefasWidget(
                                          controller: textSubtarefaController),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
