import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/button_header_tarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/button_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/text_save_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class CreateWidget extends StatefulWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget> {
  TextEditingController textController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final HomeStore store = Modular.get();

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
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonHeaderTarefaWidget(
                            constraint: constraint.maxWidth,
                            tipo: 0,
                            tamanho: constraint.maxWidth >=
                                    LarguraLayoutBuilder().telaPc
                                ? 0.20
                                : 0.27,
                          ),
                          ButtonHeaderTarefaWidget(
                            constraint: constraint.maxWidth,
                            tipo: 1,
                            tamanho: constraint.maxWidth >=
                                    LarguraLayoutBuilder().telaPc
                                ? 0.20
                                : 0.27,
                          ),
                          ButtonHeaderTarefaWidget(
                            constraint: constraint.maxWidth,
                            tipo: 2,
                            tamanho: constraint.maxWidth >=
                                    LarguraLayoutBuilder().telaPc
                                ? 0.12
                                : 0.27,
                          ),
                          if (constraint.maxWidth >=
                              LarguraLayoutBuilder().telaPc)
                            ButtonHeaderTarefaWidget(
                              constraint: constraint.maxWidth,
                              tipo: 3,
                              tamanho: 0.31,
                            ),
                          if (constraint.maxWidth >=
                              LarguraLayoutBuilder().telaPc)
                            ButtonHeaderTarefaWidget(
                              constraint: constraint.maxWidth,
                              tipo: 4,
                              dateController: dateController,
                              tamanho: 0.12,
                            ),
                          Center(
                            child: GestureDetector(
                              onTap: () => Modular.to.pop(),
                              child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: store.client.theme
                                        ? Colors.white
                                        : Colors.black,
                                    size: 36,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (constraint.maxWidth < LarguraLayoutBuilder().telaPc)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonHeaderTarefaWidget(
                              constraint: constraint.maxWidth,
                              tipo: 3,
                              tamanho: 0.55,
                            ),
                            ButtonHeaderTarefaWidget(
                              constraint: constraint.maxWidth,
                              tipo: 4,
                              dateController: dateController,
                              tamanho: 0.35,
                            ),
                          ],
                        ),
                      ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.05,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () => Modular.to.pop(),
                    //         child: MouseRegion(
                    //             cursor: SystemMouseCursors.click,
                    //             child: Icon(
                    //               Icons.close,
                    //               color: ConvertIcon().convertColor(
                    //                     store.clientCreate
                    //                         .tarefaModelSaveEtiqueta.color,
                    //                   ) ??
                    //                   Colors.grey,
                    //               size: 36,
                    //             )),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.05,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     child: Wrap(
                    //       alignment: WrapAlignment.spaceAround,
                    //       crossAxisAlignment: WrapCrossAlignment.center,
                    //       children: [
                    //         EtiquetasSaveWidget(
                    //           constraint: constraint.maxWidth,
                    //         ),
                    //         ActionFaseSaveWidget(
                    //             constraint: constraint.maxWidth),
                    //         PrioridadeSaveWidget(
                    //             constraint: constraint.maxWidth),
                    //         constraint.maxWidth >
                    //                 LarguraLayoutBuilder().larguraModal
                    //             ? SizedBox(
                    //                 width:
                    //                     MediaQuery.of(context).size.width * 0.1,
                    //                 child: MouseRegion(
                    //                   cursor: SystemMouseCursors.click,
                    //                   child: UsersSaveWidget(
                    //                       constraint: constraint.maxWidth),
                    //                 ),
                    //               )
                    //             : Container(),
                    //         constraint.maxWidth >
                    //                 LarguraLayoutBuilder().larguraModal
                    //             ? SizedBox(
                    //                 width:
                    //                     MediaQuery.of(context).size.width * 0.2,
                    //                 child: DateSaveWidget(
                    //                   dateController: dateController,
                    //                   constraint: constraint.maxWidth,
                    //                 ),
                    //               )
                    //             : Container()
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // constraint.maxWidth <= LarguraLayoutBuilder().larguraModal
                    //     ? Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           SizedBox(
                    //             width: MediaQuery.of(context).size.width * 0.5,
                    //             child: MouseRegion(
                    //               cursor: SystemMouseCursors.click,
                    //               child: UsersSaveWidget(
                    //                   constraint: constraint.maxWidth),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: MediaQuery.of(context).size.width * 0.4,
                    //             child: DateSaveWidget(
                    //               dateController: dateController,
                    //               constraint: constraint.maxWidth,
                    //             ),
                    //           )
                    //         ],
                    //       )
                    //     : Container(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                        child: TextSaveWidget(controller: textController),
                      ),
                    ),
                    Expanded(
                      child: CreateSubtarefaWidget(
                        constraint: constraint.maxWidth,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonSaveWidget(
                          color: ConvertIcon().convertColor(
                                store
                                    .clientCreate.tarefaModelSaveEtiqueta.color,
                              ) ??
                              Colors.grey,
                          constraint: constraint.maxWidth,
                        ),
                      ),
                    )
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
