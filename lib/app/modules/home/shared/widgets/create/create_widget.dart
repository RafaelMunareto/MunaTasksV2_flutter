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
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Wrap(
                                alignment: WrapAlignment.spaceAround,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  EtiquetasSaveWidget(
                                    constraint: widget.constraint,
                                  ),
                                  ActionFaseSaveWidget(
                                      constraint: widget.constraint),
                                  PrioridadeSaveWidget(
                                      constraint: widget.constraint),
                                  widget.constraint >=
                                          LarguraLayoutBuilder().telaPc
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: UsersSaveWidget(
                                              constraint: widget.constraint),
                                        )
                                      : Container(),
                                  widget.constraint >=
                                          LarguraLayoutBuilder().telaPc
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: DateSaveWidget(
                                            dateController: dateController,
                                            constraint: widget.constraint,
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    widget.constraint >= LarguraLayoutBuilder().telaPc
                        ? Container()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: UsersSaveWidget(
                                      constraint: widget.constraint),
                                ),
                              ),
                              Expanded(
                                child: DateSaveWidget(
                                  dateController: dateController,
                                  constraint: widget.constraint,
                                ),
                              ),
                            ],
                          ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                      child: TextSaveWidget(controller: textController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CreateSubtarefaWidget(
                        constraint: widget.constraint,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ButtonSaveWidget(
                        constraint: widget.constraint,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
