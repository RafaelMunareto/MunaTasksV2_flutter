import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_home_page_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/create_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/navigation_bar_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/menu_screen.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Dashboard"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final GlobalKey expansionTile = GlobalKey();
  bool appVisible = false;

  @override
  void initState() {
    if (kIsWeb || Platform.isWindows) {
      store.client.setOpen(true);
    }
    super.initState();
  }

  @override
  final HomeStore store = Modular.get();
  final drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait ||
            (kIsWeb || Platform.isWindows)) {
          return Scaffold(
            appBar: !appVisible
                ? AppBarWidget(
                    icon: Icons.bookmark,
                    home: true,
                    context: context,
                    zoomController: drawerController,
                    setOpen: store.client.setOpen,
                    settings: true,
                    theme: store.client.theme,
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
                store.clientCreate.cleanSave();
                DialogButtom().showDialogCreate(
                  const CreateWidget(),
                  context,
                );
              },
              child: Icon(
                Icons.add,
                size: kIsWeb || Platform.isWindows ? 48 : 24,
              ),
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
            body: kIsWeb || Platform.isWindows
                ? Observer(
                    builder: (_) {
                      return store.client.loading
                          ? const Center(
                              child: CircularProgressWidget(),
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
                                const Expanded(
                                  flex: 8,
                                  child: BodyHomePageWidget(),
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
                            ? const Center(child: CircularProgressWidget())
                            : MenuScreen(
                                open: store.client.open,
                                setOpen: store.client.setOpen,
                                controller: drawerController,
                              );
                      },
                    ),
                    mainScreen: const BodyHomePageWidget(),
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
