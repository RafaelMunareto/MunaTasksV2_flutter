import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_home_page_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/navigation_bar_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/menu_screen.dart';

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
  late AnimationController createController;
  bool appVisible = false;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      setState(() {
        store.client.setOpen(true);
      });
    }

    _controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    createController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    createController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        setState(() {
          if (store.client.expand != appVisible) {
            appVisible = store.client.expand;
          }
        });
      },
    );
  }

  @override
  final HomeStore store = Modular.get();
  final drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    opacidade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.9),
      ),
    );

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait || kIsWeb) {
          return Scaffold(
            appBar: !appVisible
                ? AppBarWidget(
                    icon: Icons.bookmark,
                    home: true,
                    context: context,
                    zoomController: drawerController,
                    setOpen: store.client.setOpen,
                    settings: true,
                    back: false,
                    etiquetaList: store.client.etiquetas,
                    tarefas: store.client.taskDio,
                    setValueSearch: store.client.setSearchValue,
                    etiquetaSelection: store.client.etiquetaSelection,
                    setEtiquetaSelection: store.client.setEtiquetaSelection,
                    changeFilterSearch: store.changeFilterSearchList,
                  )
                : PreferredSize(
                    child: Container(),
                    preferredSize: const Size(0, 32),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                store.client.setExpand(!store.client.expand);
                setState(() {
                  store.client.expand
                      ? createController.forward()
                      : createController.reverse();
                  store.clientCreate.cleanSave();
                });
              },
              child: Icon(
                Icons.add,
                size: kIsWeb ? 48 : 24,
                color: Colors.grey[300],
              ),
              backgroundColor: Colors.red,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: Observer(builder: (_) {
              return NavigationBarWidget(
                theme: store.client.theme,
                navigateBarSelection: store.client.navigateBarSelection,
                setNavigateBarSelection: store.setNavigateBarSelection,
              );
            }),
            body: kIsWeb
                ? Observer(
                    builder: (_) {
                      return store.client.loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: MenuScreen(
                                    open: store.client.open,
                                    setOpen: store.client.setOpen,
                                    controller: drawerController,
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: BodyHomePageWidget(
                                    createController: createController,
                                    opacidade: opacidade,
                                  ),
                                ),
                              ],
                            );
                    },
                  )
                : ZoomDrawer(
                    controller: drawerController,
                    style: DrawerStyle.Style1,
                    menuScreen: Observer(
                      builder: (_) {
                        return store.client.loading
                            ? const Center(child: CircularProgressIndicator())
                            : MenuScreen(
                                open: store.client.open,
                                setOpen: store.client.setOpen,
                                controller: drawerController,
                              );
                      },
                    ),
                    mainScreen: BodyHomePageWidget(
                      createController: createController,
                      opacidade: opacidade,
                    ),
                    borderRadius: 24.0,
                    showShadow: false,
                    backgroundColor: Colors.transparent,
                    slideWidth: MediaQuery.of(context).size.width * .65,
                    openCurve: Curves.fastOutSlowIn,
                    closeCurve: Curves.easeInOut,
                  ),
          );
        } else {
          return const LandscapeWidget();
        }
      },
    );
  }
}
