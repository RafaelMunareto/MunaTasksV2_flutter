import 'package:accordion/accordion.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class LandscapeIntWidget extends StatefulWidget {
  final double constraint;
  final bool theme;
  const LandscapeIntWidget({
    Key? key,
    required this.constraint,
    required this.theme,
  }) : super(key: key);

  @override
  State<LandscapeIntWidget> createState() => _LandscapeIntWidgetState();
}

class _LandscapeIntWidgetState extends State<LandscapeIntWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();

    return Observer(builder: (_) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: widget.constraint >= LarguraLayoutBuilder().telaPc
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                child: Accordion(
                  maxOpenSections: 1,
                  children: [
                    for (var totais in store.client.tarefasTotais)
                      AccordionSection(
                        headerBackgroundColor: widget.theme
                            ? darkThemeData(context).primaryColorLight
                            : lightThemeData(context).primaryColorLight,
                        contentBackgroundColor: widget.theme
                            ? darkThemeData(context).scaffoldBackgroundColor
                            : lightThemeData(context).scaffoldBackgroundColor,
                        header: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              child: InputChip(
                                backgroundColor: widget.theme
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade300,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                key: UniqueKey(),
                                labelPadding: const EdgeInsets.all(2),
                                elevation: 1.0,
                                avatar: CircleAvatarWidget(
                                  nameUser: totais.name.name.name,
                                  url: totais.name!.urlImage,
                                ),
                                label: SizedBox(
                                  width: widget.constraint >=
                                          LarguraLayoutBuilder().telaPc
                                      ? MediaQuery.of(context).size.width * 0.07
                                      : MediaQuery.of(context).size.width * 0.3,
                                  child: AutoSizeText(
                                    ' ' + totais.name!.name.name,
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: widget.theme
                                            ? Colors.white
                                            : Colors.grey.shade800),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            totais.qtd > 0
                                ? AutoSizeText(
                                    totais.qtd > 1
                                        ? totais.qtd.toString() + ' Tarefas'
                                        : totais.qtd.toString() + ' Tarefa',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ))
                                : const AutoSizeText('Nenhuma tarefa',
                                    maxLines: 1,
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: InputChip(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        key: UniqueKey(),
                                        labelPadding: const EdgeInsets.all(2),
                                        elevation: 1.0,
                                        avatar: Icon(
                                          IconData(task.etiqueta.icon ?? 0,
                                              fontFamily: 'MaterialIcons'),
                                          color: ConvertIcon().convertColor(
                                              task.etiqueta.color),
                                        ),
                                        label: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            task.texto,
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
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
