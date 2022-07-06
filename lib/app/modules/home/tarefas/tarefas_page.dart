import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
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
  bool theme = false;
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
                    ? MediaQuery.of(context).size.width * 0.5
                    : MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: theme
                              ? Colors.black54
                              : lightThemeData(context)
                                  .shadowColor
                                  .withOpacity(0.2),
                        ),
                        BoxShadow(
                          color: theme
                              ? darkThemeData(context).scaffoldBackgroundColor
                              : lightThemeData(context).scaffoldBackgroundColor,
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
                                          .contains(
                                              txtBuscaValue.text.toLowerCase()))
                                      .toList();
                                },
                                displayStringForOption:
                                    (PerfilDioModel option) => option.name.name
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kWhite, width: 1.3),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kblue, width: 1.9),
                                            ),
                                          ),
                                          controller: fieldTextEditingController
                                            ..text = ' Selecione um usuário',
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
                                      elevation: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: kWhite, spreadRadius: 1),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.295,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(10.0),
                                            itemCount: options.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final PerfilDioModel option =
                                                  options.elementAt(index);

                                              return GestureDetector(
                                                  onTap: () async {
                                                    onSelected(option);
                                                  },
                                                  child: MouseRegion(
                                                    child: ListTile(
                                                        title: AutoSizeText(
                                                            option.name.name
                                                                .toString()
                                                                .toUpperCase(),
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: theme
                                                                    ? lightThemeData(
                                                                            context)
                                                                        .focusColor
                                                                    : darkThemeData(
                                                                            context)
                                                                        .scaffoldBackgroundColor))),
                                                  ));
                                            }),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
