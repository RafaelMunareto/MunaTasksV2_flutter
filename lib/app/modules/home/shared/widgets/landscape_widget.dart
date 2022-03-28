import 'package:accordion/accordion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class LandscapeWidget extends StatefulWidget {
  const LandscapeWidget({Key? key}) : super(key: key);

  @override
  State<LandscapeWidget> createState() => _LandscapeWidgetState();
}

class _LandscapeWidgetState extends State<LandscapeWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return store.client.loading
        ? Container()
        : kIsWeb
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Accordion(
                          maxOpenSections: 1,
                          headerBackgroundColor: store.client.theme
                              ? Colors.blueGrey[800]
                              : Colors.blueGrey[200],
                          children: [
                            for (var totais in store.client.tarefasTotais)
                              AccordionSection(
                                contentBorderColor: Colors.grey,
                                header: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: InputChip(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        backgroundColor: store.client.theme
                                            ? Colors.grey[600]
                                            : Colors.white,
                                        key: UniqueKey(),
                                        labelPadding: const EdgeInsets.all(2),
                                        elevation: 2.0,
                                        avatar: CircleAvatarWidget(
                                          url: totais.name!.urlImage,
                                        ),
                                        label: SizedBox(
                                          width: 100,
                                          child: Text(
                                            totais.name!.name.name,
                                            textAlign: TextAlign.justify,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    totais.qtd > 0
                                        ? Text(
                                            totais.qtd.toString() + ' Tarefas',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ))
                                        : const Text('Nenhuma tarefa',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            )),
                                  ],
                                ),
                                content: Wrap(
                                  children: [
                                    for (var task in totais.tarefa ?? [])
                                      totais.tarefa.isEmpty
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InputChip(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                key: UniqueKey(),
                                                labelPadding:
                                                    const EdgeInsets.all(2),
                                                elevation: 1.0,
                                                avatar: Icon(
                                                  IconData(
                                                      task.etiqueta.icon ?? 0,
                                                      fontFamily:
                                                          'MaterialIcons'),
                                                  color: ConvertIcon()
                                                      .convertColor(
                                                          task.etiqueta.color),
                                                ),
                                                label: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text(
                                                    task.texto,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    children: [
                      SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Accordion(
                            maxOpenSections: 1,
                            headerBackgroundColor: Colors.blueGrey[200],
                            children: [
                              for (var totais in store.client.tarefasTotais)
                                AccordionSection(
                                  contentBorderColor: Colors.grey,
                                  header: Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: InputChip(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              ),
                                            ),
                                            backgroundColor: Colors.white,
                                            key: UniqueKey(),
                                            labelPadding:
                                                const EdgeInsets.all(2),
                                            elevation: 2.0,
                                            avatar: CircleAvatarWidget(
                                              url: totais.name!.urlImage,
                                            ),
                                            label: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                totais.name!.name.name,
                                                textAlign: TextAlign.justify,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        totais.qtd > 0
                                            ? Text(
                                                totais.qtd.toString() +
                                                    ' Tarefas',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : const Text(
                                                'Nenhuma tarefa',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ]),
                                  content: Wrap(
                                    children: [
                                      for (var task in totais.tarefa ?? [])
                                        totais.tarefa == null
                                            ? Container()
                                            : InputChip(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                key: UniqueKey(),
                                                labelPadding:
                                                    const EdgeInsets.all(2),
                                                elevation: 1.0,
                                                avatar: Icon(
                                                  IconData(
                                                      task.etiqueta.icon ?? 0,
                                                      fontFamily:
                                                          'MaterialIcons'),
                                                  color: ConvertIcon()
                                                      .convertColor(
                                                          task.etiquetas.color),
                                                ),
                                                label: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text(
                                                    task.etiqueta.etiqueta,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                onPressed: () {},
                                              ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
