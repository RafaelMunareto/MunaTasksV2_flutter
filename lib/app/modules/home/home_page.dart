import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/navigation_bar_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/menu_screen.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Dashboard"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> opacidade;
  final GlobalKey expansionTile = GlobalKey();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  final HomeStore store = Modular.get();
  final drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    opacidade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.9),
      ),
    );
    return Scaffold(
      appBar: AppBarWidget(
          icon: Icons.bookmark,
          home: true,
          context: context,
          zoomController: drawerController,
          setOpen: store.setOpen,
          settings: true,
          back: false,
          etiquetaList: store.tarefas,
          etiquetaSelection: store.etiquetaSelection,
          setEtiquetaSelection: store.setEtiquetaSelection),
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
            controller: _controller,
            navigateBarSelection: store.navigateBarSelection,
            setNavigateBarSelection: store.setNavigateBarSelection,
            badgets: store.badgetNavigate);
      }),
      body: ZoomDrawer(
        controller: drawerController,
        style: DrawerStyle.Style1,
        menuScreen: Observer(
          builder: (_) {
            return MenuScreen(
              open: store.open,
              controller: drawerController,
            );
          },
        ),
        mainScreen: Observer(builder: (_) {
          return !store.loading
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ExpansionTile(
                          leading: store.icon != 0
                              ? Icon(
                                  IconData(store.icon,
                                      fontFamily: 'MaterialIcons'),
                                  color:
                                      ConvertIcon().convertColor(store.color),
                                )
                              : const Icon(
                                  Icons.bookmark,
                                  color: Colors.blue,
                                ),
                          title: Text(
                            store.etiquetaSelection,
                            style: TextStyle(
                              color: ConvertIcon().convertColor(
                                  store.color != '' ? store.color : 'blue'),
                            ),
                          ),
                          children: <Widget>[
                            Observer(
                              builder: (_) {
                                return RadioEtiquetasFilterWidget(
                                  changeFilterEtiquetaList:
                                      store.changeFilterEtiquetaList,
                                  etiquetaList: store.etiquetaList,
                                  etiquetaSelection: store.etiquetaSelection,
                                  setColor: store.setColor,
                                  setClosedListExpanded:
                                      store.setClosedListExpanded,
                                  closedListExpanded: store.closedListExpanded,
                                  setIcon: store.setIcon,
                                  setEtiquetaSelection:
                                      store.setEtiquetaSelection,
                                );
                              },
                            ),
                          ],
                        ),
                        ExpansionTile(
                          leading: const Icon(
                            Icons.filter_alt,
                            color: Colors.black45,
                          ),
                          title: Text(
                            store.ordenamentoSelection,
                          ),
                          children: <Widget>[
                            Observer(
                              builder: (_) {
                                return RadioEtiquetasFilterWidget(
                                  changeFilterEtiquetaList:
                                      store.changeFilterEtiquetaList,
                                  etiquetaList: store.etiquetaList,
                                  etiquetaSelection: store.etiquetaSelection,
                                  setColor: store.setColor,
                                  setClosedListExpanded:
                                      store.setClosedListExpanded,
                                  closedListExpanded: store.closedListExpanded,
                                  setIcon: store.setIcon,
                                  setEtiquetaSelection:
                                      store.setEtiquetaSelection,
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: CardWidget(
                              theme: store.theme,
                              navigateBarSelection: store.navigateBarSelection,
                              opacidade: opacidade,
                              tarefa: store.tarefas,
                              navigate: store.navigateBarSelection,
                              deleteTasks: store.deleteTasks,
                              save: store.save),
                        ),
                      ],
                    ),
                  ),
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
