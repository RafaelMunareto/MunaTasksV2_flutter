import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/tarefas/shared/widgets/autocomplete_widget.dart';
import 'package:munatasks2/app/modules/home/tarefas/shared/widgets/chart_widget.dart';
import 'package:munatasks2/app/modules/home/tarefas/tarefas_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/menu_screen.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
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
                          const AutocompleteWidget(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Card(
                                    elevation: 3,
                                    //color: Colors.black.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ChartWidget(
                                          constraint: constraint.maxWidth),
                                    ),
                                  ),
                                ),
                              ),
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
