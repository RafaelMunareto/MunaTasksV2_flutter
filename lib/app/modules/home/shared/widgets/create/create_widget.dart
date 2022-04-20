import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/action_fase_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/button_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/date_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/etiquetas_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/prioridade_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/text_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/users_save_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class CreateWidget extends StatefulWidget {
  const CreateWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget> {
  TextEditingController textController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: ConvertIcon().convertColor(
                      store.clientCreate.tarefaModelSaveEtiqueta.color,
                    ),
                    width: 2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: EtiquetasSaveWidget(),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ActionFaseSaveWidget(),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: UsersSaveWidget(),
                              ),
                              const PrioridadeSaveWidget(),
                              DateSaveWidget(dateController: dateController),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Wrap(children: [
                            TextSaveWidget(controller: textController),
                            const CreateSubtarefaWidget()
                          ]),
                        ),
                      ],
                    ),
                  ),
                  const ButtonSaveWidget()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
