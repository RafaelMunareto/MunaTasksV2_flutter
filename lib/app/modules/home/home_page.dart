// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/utils/functions_utils.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card/list_card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_int_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/logo_widget.dart';
import 'package:munatasks2/app/shared/components/menu_screen.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Dashboard"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey expansionTile = GlobalKey();
  final HomeStore store = Modular.get();
  final drawerController = ZoomDrawerController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        if (!kIsWeb) {
          if (defaultTargetPlatform == Platform.isWindows &&
              store.client.checkUpdateDesktop) {
            FunctionsUtils().checkUpdateDesktop(context);
          }
          if (store.client.msgError != '') {
            SnackbarCustom().createSnackBareErrOrGoal(_scaffoldKey,
                message: store.client.msgError, errOrGoal: false);

            store.client.setMsgError('');
          }
        }
      },
    );
  }

  @override
  void initState() {
    store.client.buscaTheme(context);
    store.connectToServer();
    tz.initializeTimeZones();
    FunctionsUtils().sendNotification();
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      FunctionsUtils().verifyVersion(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    FunctionsUtils().sendNotification();
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth >= LarguraLayoutBuilder().telaPc) {
        store.client.setOpen(true);
      }
      return OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait ||
              (kIsWeb || defaultTargetPlatform == TargetPlatform.windows)) {
            return Observer(builder: (_) {
              return Scaffold(
                appBar: AppBarWidget(
                  icon: Icons.bookmark,
                  home: true,
                  context: context,
                  zoomController: drawerController,
                  setOpen: store.client.setOpen,
                  settings: true,
                  back: false,
                  etiquetaList: store.client.etiquetas,
                  setValueSearch: store.client.setSearchValue,
                  changeFilterSearch: store.changeFilterSearchList,
                  client: store.client,
                  getDioFase: store.getDio,
                  getPass: store.getPass,
                  closeSearch: store.client.closeSearch,
                  setCloseSearch: store.client.setCloseSearch,
                ),
                drawer: Drawer(
                  child: MenuScreen(
                    constraint: constraint.maxWidth,
                    open: store.client.open,
                    setOpen: store.client.setOpen,
                    controller: drawerController,
                    version: store.client.version,
                  ),
                ),
                body: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                    ? Observer(
                        builder: (_) {
                          return Scaffold(
                            body: store.client.loading
                                ? LogoWidget(constraint: constraint.maxWidth)
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: ListCardWidget(
                                            badgets: store.client.badgets[0],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: ListCardWidget(
                                            badgets: store.client.badgets[1],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: ListCardWidget(
                                            badgets: store.client.badgets[2],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: ListCardWidget(
                                            badgets: store.client.badgets[3],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: LandscapeIntWidget(
                                            constraint: constraint.maxWidth,
                                            theme: store.client.theme,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                    constraint: constraint.maxWidth,
                                    open: store.client.open,
                                    setOpen: store.client.setOpen,
                                    controller: drawerController,
                                    version: store.client.version,
                                  );
                          },
                        ),
                        mainScreen: Container(),
                        borderRadius: 24.0,
                        showShadow: false,
                        backgroundColor: Colors.transparent,
                        slideWidth: MediaQuery.of(context).size.width * .65,
                        openCurve: Curves.fastOutSlowIn,
                        closeCurve: Curves.easeInOut,
                      ),
              );
            });
          } else {
            return LandscapeIntWidget(
              constraint: constraint.maxWidth,
              theme: store.client.theme,
            );
          }
        },
      );
    });
  }
}
