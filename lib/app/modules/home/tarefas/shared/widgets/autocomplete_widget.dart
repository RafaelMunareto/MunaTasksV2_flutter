import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/tarefas/tarefas_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class AutocompleteWidget extends StatefulWidget {
  const AutocompleteWidget({Key? key}) : super(key: key);

  @override
  State<AutocompleteWidget> createState() => _AutocompleteWidgetState();
}

class _AutocompleteWidgetState extends State<AutocompleteWidget> {
  TarefasStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          child: Autocomplete<PerfilDioModel>(
            optionsBuilder: (TextEditingValue txtBuscaValue) {
              return store.client.perfis
                  .where((PerfilDioModel perfil) => perfil.name.name
                      .toLowerCase()
                      .contains(txtBuscaValue.text.toLowerCase()))
                  .toList();
            },
            displayStringForOption: (PerfilDioModel option) =>
                option.name.name.toString().toUpperCase(),
            fieldViewBuilder: (BuildContext context,
                TextEditingController fieldTextEditingController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted) {
              return GestureDetector(
                child: SizedBox(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, right: 10),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kWhite, width: 1.3),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kblue, width: 1.9),
                        ),
                      ),
                      controller: fieldTextEditingController
                        ..text = ' Selecione um usuário',
                      focusNode: fieldFocusNode,
                      onTap: () => fieldTextEditingController.clear(),
                    ),
                  ),
                ),
              );
            },
            onSelected: (PerfilDioModel selection) {},
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<PerfilDioModel> onSelected,
                Iterable<PerfilDioModel> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Card(
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: store.client.theme
                              ? Colors.white.withOpacity(0.7)
                              : kblue.withOpacity(0.7)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: MediaQuery.of(context).size.width * 0.695,
                    height: MediaQuery.of(context).size.width * 0.2,
                    child: Container(
                      color: store.client.theme
                          ? darkThemeData(context).cardColor
                          : lightThemeData(context).cardColor,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final PerfilDioModel option =
                                options.elementAt(index);

                            return GestureDetector(
                                onTap: () async {
                                  onSelected(option);
                                  await store.clientStore
                                      .setIdSelection(option.id);
                                  store.buscaTarefa();
                                },
                                child: MouseRegion(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color: store.client.theme
                                                    ? Colors.white
                                                        .withOpacity(0.3)
                                                    : kblue.withOpacity(0.5)))),
                                    child: ListTile(
                                        title: AutoSizeText(
                                            option.name.name
                                                .toString()
                                                .toUpperCase(),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: store.client.theme
                                                    ? Colors.white
                                                    : Colors.black))),
                                  ),
                                ));
                          }),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
