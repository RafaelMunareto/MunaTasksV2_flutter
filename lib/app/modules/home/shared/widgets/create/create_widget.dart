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
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Modular.to.pop(),
                        child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Icon(
                              Icons.close,
                              color: ConvertIcon().convertColor(
                                    store.clientCreate.tarefaModelSaveEtiqueta
                                        .color,
                                  ) ??
                                  Colors.grey,
                              size: 36,
                            )),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        EtiquetasSaveWidget(
                          constraint: widget.constraint,
                        ),
                        ActionFaseSaveWidget(constraint: widget.constraint),
                        PrioridadeSaveWidget(constraint: widget.constraint),
                        widget.constraint > LarguraLayoutBuilder().telaPc
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: UsersSaveWidget(
                                    constraint: widget.constraint),
                              )
                            : Container(),
                        widget.constraint > LarguraLayoutBuilder().telaPc
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: DateSaveWidget(
                                  dateController: dateController,
                                  constraint: widget.constraint,
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                    child: TextSaveWidget(controller: textController),
                  ),
                ),
                Flexible(
                  flex: 21,
                  child: CreateSubtarefaWidget(
                    constraint: widget.constraint,
                  ),
                ),
                Expanded(child: Container()),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonSaveWidget(
                      color: ConvertIcon().convertColor(
                            store.clientCreate.tarefaModelSaveEtiqueta.color,
                          ) ??
                          Colors.grey,
                      constraint: widget.constraint,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
