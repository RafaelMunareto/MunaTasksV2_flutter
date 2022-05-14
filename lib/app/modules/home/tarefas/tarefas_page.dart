import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_widget.dart';
import 'package:munatasks2/app/modules/home/tarefas/tarefas_store.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
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

class TarefasPageState extends ModularState<TarefasPage, TarefasStore> {
  bool theme = false;
  ILocalStorage storage = LocalStorageShare();
  @override
  void initState() {
    storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        setState(() {
          theme = true;
        });
      } else {
        setState(() {
          theme = false;
        });
      }
    });
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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                    ? MediaQuery.of(context).size.width * 0.5
                    : MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                    child: LandscapeWidget(
                      theme: store.theme,
                      constraint: constraint.maxWidth,
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
