import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/navigation_bar_widget.dart';
import 'package:munatasks2/app/shared/components/menu_screen.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Dashboard"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  final HomeStore store = Modular.get();
  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    TarefaModel tarefaSave = TarefaModel(
        etiqueta: 'Desenvolvimento',
        texto: 'Aplicativo GESUN para Windows. ELECTRON. ',
        data: '30/12/2021',
        users: [
          'usuarios/uRVW36YywWcM4PUl48fqcHzTGDW2'
        ],
        subTarefa: [
          SubtarefaModel(
              status: 'check',
              title: 'especificacao',
              texto: 'especificar o sistema',
              user: 'usuarios/uRVW36YywWcM4PUl48fqcHzTGDW2'),
        ]);

    //store.save(tarefaSave);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => _drawerController.toggle!(),
          child: const Icon(Icons.menu),
        ),
        title: const Text('MunaTasks'),
        actions: const [
          Icon(
            Icons.bookmark_border,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.reorder),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      bottomSheet: Observer(builder: (_) {
        return NavigationBarWidget(
          navigateBarSelection: store.navigateBarSelection,
          setNavigateBarSelection: store.setNavigateBarSelection,
        );
      }),
      body: ZoomDrawer(
        controller: _drawerController,
        style: DrawerStyle.Style1,
        menuScreen: MenuScreen(
          controller: _drawerController,
        ),
        mainScreen: Observer(builder: (_) {
          return !store.loading
              ? CardWidget(
                  tarefa: store.tarefas,
                  delete: store.delete,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                  ],
                );
        }),
        borderRadius: 24.0,
        showShadow: false,
        backgroundColor: Colors.transparent,
        slideWidth: MediaQuery.of(context).size.width * .65,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.easeInOut,
      ),
    );
  }
}
