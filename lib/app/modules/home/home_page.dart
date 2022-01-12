import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/navigation_bar_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
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
  final drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    // TarefaModel tarefaSave = TarefaModel(
    //     etiqueta: 'Desenvolvimento',
    //     texto: 'feito Aplicativo GESUN para Windows. ELECTRON. ',
    //     fase: 2,
    //     data: '30/12/2021',
    //     users: [
    //       '/usuarios/uRVW36YywWcM4PUl48fqcHzTGDW2'
    //     ],
    //     subTarefa: [
    //       SubtarefaModel(
    //           status: 'check',
    //           title: 'especificacao',
    //           texto: 'especificar o sistema',
    //           user: '/usuarios/uRVW36YywWcM4PUl48fqcHzTGDW2'),
    //     ]);

    // store.save(tarefaSave);
    // store.save(tarefaSave);
    // store.save(tarefaSave);

    return Scaffold(
      appBar: AppBarWidget(
        icon: Icons.bookmark,
        home: true,
        context: context,
        zoomController: drawerController,
        settings: true,
        back: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Observer(builder: (_) {
        return NavigationBarWidget(
            key: UniqueKey(),
            theme: store.theme,
            navigateBarSelection: store.navigateBarSelection,
            setNavigateBarSelection: store.setNavigateBarSelection,
            badgets: store.badgetNavigate);
      }),
      body: ZoomDrawer(
        controller: drawerController,
        style: DrawerStyle.Style1,
        menuScreen: MenuScreen(
          controller: drawerController,
        ),
        mainScreen: Observer(builder: (_) {
          return !store.loading
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                  child: CardWidget(
                      tarefa: store.tarefas,
                      navigate: store.navigateBarSelection,
                      deleteTasks: store.deleteTasks,
                      save: store.save),
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
