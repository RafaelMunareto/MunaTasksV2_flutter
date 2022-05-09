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
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class CreateWidget extends StatefulWidget {
  final double constraint;
  const CreateWidget({Key? key, required this.constraint}) : super(key: key);

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
                      ) ??
                      Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex:
                              widget.constraint >= LarguraLayoutBuilder().telaPc
                                  ? 2
                                  : 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: EtiquetasSaveWidget(
                                  constraint: widget.constraint,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ActionFaseSaveWidget(
                                    constraint: widget.constraint),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: UsersSaveWidget(
                                    constraint: widget.constraint),
                              ),
                              PrioridadeSaveWidget(
                                  constraint: widget.constraint),
                              widget.constraint >= LarguraLayoutBuilder().telaPc
                                  ? DateSaveWidget(
                                      dateController: dateController,
                                      constraint: widget.constraint,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        Expanded(
                          flex:
                              widget.constraint > LarguraLayoutBuilder().telaPc
                                  ? 8
                                  : 7,
                          child: Wrap(children: [
                            TextSaveWidget(controller: textController),
                            CreateSubtarefaWidget(
                              constraint: widget.constraint,
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                  widget.constraint < LarguraLayoutBuilder().telaPc
                      ? Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: DateSaveWidget(
                              dateController: dateController,
                              constraint: widget.constraint,
                            ),
                          ),
                        )
                      : Container(),
                  ButtonSaveWidget(
                    constraint: widget.constraint,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
