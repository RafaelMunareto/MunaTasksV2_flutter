import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/button_header_create_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/button_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/button_save_create_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/subtarefas_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/text_save_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

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
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Modular.to.pop(),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ButtonHeaderCreateWidget(
                                      constraint: constraint.maxWidth,
                                      tipo: 0,
                                    ),
                                    ButtonHeaderCreateWidget(
                                      constraint: constraint.maxWidth,
                                      tipo: 1,
                                    ),
                                    ButtonHeaderCreateWidget(
                                      constraint: constraint.maxWidth,
                                      tipo: 2,
                                    ),
                                    ButtonHeaderCreateWidget(
                                      constraint: constraint.maxWidth,
                                      tipo: 4,
                                      dateController: dateController,
                                    ),
                                    ButtonHeaderCreateWidget(
                                      constraint: constraint.maxWidth,
                                      tipo: 3,
                                    ),
                                  ],
                                ),
                              ),
                              TextSaveWidget(
                                controller: textController,
                                subtarefa: false,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 2, 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ButtonHeaderCreateWidget(
                                      constraint: constraint.maxWidth,
                                      tipo: 5,
                                    ),
                                    ButtonHeaderCreateWidget(
                                      constraint: constraint.maxWidth,
                                      tipo: 6,
                                    ),
                                    ButtonHeaderCreateWidget(
                                      constraint: constraint.maxWidth,
                                      tipo: 7,
                                      dateController: dateController,
                                    ),
                                    ButtonHeaderCreateWidget(
                                      constraint: constraint.maxWidth,
                                      tipo: 8,
                                    ),
                                  ],
                                ),
                              ),
                              TextSaveWidget(
                                controller: textSubtarefaController,
                                subtarefa: true,
                              ),
                              ButtonSaveCreateSubtarefaWidget(
                                texto: textSubtarefaController,
                                constraint: constraint.maxWidth,
                              ),
                            ],
                          ),
                          SubtarefasWidget(controller: textSubtarefaController)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
//  ButtonSaveWidget(
//                                       constraint: constraint.maxWidth,
//                                       color: kblue)