import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:munatasks2/app/modules/home/tarefas/tarefas_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/menu_screen.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class TarefasPage extends StatefulWidget {
  final String title;
  const TarefasPage({
    Key? key,
    this.title = 'Tarefas',
  }) : super(key: key);
  @override
  TarefasPageState createState() => TarefasPageState();
}

class TarefasPageState extends State<TarefasPage> {
  ILocalStorage storage = LocalStorageShare();
  TarefasStore store = Modular.get();
  List<String> suggestions1 = [];
  final List<PerfilDioModel> perfil = [];

  initList() async {
    await store.client.buscaTheme(context);
    await store.usersAutoComplete();
  }

  @override
  void initState() {
    initList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Observer(builder: (_) {
        return Scaffold(
            appBar: AppBarWidget(
                title: widget.title,
                context: context,
                icon: Icons.task,
                settings: true,
                rota: '/home/',
                back: true),
            drawer: Drawer(
              child: MenuScreen(
                constraint: constraint.maxWidth,
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                      ? MediaQuery.of(context).size.width * 0.9
                      : MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: store.client.theme
                                ? Colors.black54
                                : lightThemeData(context)
                                    .shadowColor
                                    .withOpacity(0.15),
                          ),
                          BoxShadow(
                            color: store.client.theme
                                ? darkThemeData(context).scaffoldBackgroundColor
                                : lightThemeData(context)
                                    .scaffoldBackgroundColor,
                            spreadRadius: -3.0,
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 3,
                                child: Autocomplete<PerfilDioModel>(
                                  optionsBuilder:
                                      (TextEditingValue txtBuscaValue) {
                                    return store.client.perfis
                                        .where((PerfilDioModel perfil) => perfil
                                            .name.name
                                            .toLowerCase()
                                            .contains(txtBuscaValue.text
                                                .toLowerCase()))
                                        .toList();
                                  },
                                  displayStringForOption:
                                      (PerfilDioModel option) => option
                                          .name.name
                                          .toString()
                                          .toUpperCase(),
                                  fieldViewBuilder: (BuildContext context,
                                      TextEditingController
                                          fieldTextEditingController,
                                      FocusNode fieldFocusNode,
                                      VoidCallback onFieldSubmitted) {
                                    return GestureDetector(
                                      child: SizedBox(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.70,
                                          child: TextField(
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kWhite, width: 1.3),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kblue, width: 1.9),
                                              ),
                                            ),
                                            controller:
                                                fieldTextEditingController
                                                  ..text =
                                                      ' Selecione um usuário',
                                            focusNode: fieldFocusNode,
                                            onTap: () =>
                                                fieldTextEditingController
                                                    .clear(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  onSelected: (PerfilDioModel selection) {},
                                  optionsViewBuilder: (BuildContext context,
                                      AutocompleteOnSelected<PerfilDioModel>
                                          onSelected,
                                      Iterable<PerfilDioModel> options) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Card(
                                        elevation: 3,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: store.client.theme
                                                    ? Colors.white
                                                        .withOpacity(0.7)
                                                    : kblue.withOpacity(0.7)),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.695,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Container(
                                            color: store.client.theme
                                                ? darkThemeData(context)
                                                    .cardColor
                                                : lightThemeData(context)
                                                    .cardColor,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                itemCount: options.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final PerfilDioModel option =
                                                      options.elementAt(index);

                                                  return GestureDetector(
                                                      onTap: () async {
                                                        onSelected(option);
                                                      },
                                                      child: MouseRegion(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: store
                                                                              .client
                                                                              .theme
                                                                          ? Colors
                                                                              .white
                                                                              .withOpacity(0.3)
                                                                          : kblue.withOpacity(0.5)))),
                                                          child: ListTile(
                                                              title: AutoSizeText(
                                                                  option
                                                                      .name.name
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                      color: store
                                                                              .client
                                                                              .theme
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black))),
                                                        ),
                                                      ));
                                                }),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.50,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: Card(
                                          elevation: 3,
                                          //color: Colors.black.withOpacity(0.3),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Chart(
                                                duration: const Duration(
                                                    milliseconds: 100),
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 10),
                                                layers: [
                                                  ChartGridLayer(
                                                    settings: ChartGridSettings(
                                                      x: ChartGridSettingsAxis(
                                                        color: store
                                                                .client.theme
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    0.01)
                                                            : Colors.black
                                                                .withOpacity(
                                                                    0.01),
                                                        frequency: 1.0,
                                                        max: 14.0,
                                                        min: 7.0,
                                                      ),
                                                      y: ChartGridSettingsAxis(
                                                        color: store
                                                                .client.theme
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    0.15)
                                                            : Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                        frequency: 50.0,
                                                        max: 300.0,
                                                        min: 0.0,
                                                      ),
                                                    ),
                                                  ),
                                                  ChartAxisLayer(
                                                    settings: ChartAxisSettings(
                                                      x: ChartAxisSettingsAxis(
                                                        frequency: 1.0,
                                                        max: 13.0,
                                                        min: 7.0,
                                                        textStyle: TextStyle(
                                                          color: store
                                                                  .client.theme
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.6)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.6),
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                      y: ChartAxisSettingsAxis(
                                                        frequency: 100.0,
                                                        max: 330.0,
                                                        min: 0.0,
                                                        textStyle: TextStyle(
                                                          color: store
                                                                  .client.theme
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.6)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.6),
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                    ),
                                                    labelX: (value) => 'Nome',
                                                    labelY: (value) => value
                                                        .toInt()
                                                        .toString(),
                                                  ),
                                                  ChartGroupBarLayer(
                                                    items: List.generate(
                                                      13 - 7 + 1,
                                                      (index) => [
                                                        ChartGroupBarDataItem(
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 76, 175, 80),
                                                          x: index + 7,
                                                          value: Random()
                                                                  .nextInt(
                                                                      280) +
                                                              20,
                                                        ),
                                                        ChartGroupBarDataItem(
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 255, 193, 7),
                                                          x: index + 7,
                                                          value: Random()
                                                                  .nextInt(
                                                                      280) +
                                                              20,
                                                        ),
                                                        ChartGroupBarDataItem(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              33, 150, 243),
                                                          x: index + 7,
                                                          value: Random()
                                                                  .nextInt(
                                                                      280) +
                                                              20,
                                                        ),
                                                      ],
                                                    ),
                                                    settings:
                                                        ChartGroupBarSettings(
                                                      thickness: constraint
                                                                  .maxWidth >=
                                                              LarguraLayoutBuilder()
                                                                  .telaPc
                                                          ? 15.0
                                                          : 10,
                                                      radius: const BorderRadius
                                                              .only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.0)),
                                                    ),
                                                  ),
                                                  ChartTooltipLayer(
                                                    shape: () =>
                                                        ChartTooltipBarShape<
                                                            ChartGroupBarDataItem>(
                                                      backgroundColor: store
                                                              .client.theme
                                                          ? Colors.white
                                                              .withOpacity(0.78)
                                                          : Colors.black
                                                              .withOpacity(
                                                                  0.78),
                                                      currentPos: (item) =>
                                                          item.currentValuePos,
                                                      currentSize: (item) =>
                                                          item.currentValueSize,
                                                      onTextValue: (item) =>
                                                          '${item.value.toString()}',
                                                      marginBottom: 6.0,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 12.0,
                                                        vertical: 8.0,
                                                      ),
                                                      radius: 6.0,
                                                      textStyle: TextStyle(
                                                        color: store
                                                                .client.theme
                                                            ? Color.fromARGB(
                                                                255, 19, 11, 36)
                                                            : Colors.white,
                                                        letterSpacing: 0.2,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          )))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      });
    });
  }
}
