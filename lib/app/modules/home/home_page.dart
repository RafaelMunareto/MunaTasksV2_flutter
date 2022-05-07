import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/body_home_page_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/create_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/navigation_bar_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/menu_screen.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:timezone/data/latest.dart' as tz;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        if (store.client.settingsUser.mobile) {
          if (!kIsWeb && defaultTargetPlatform != TargetPlatform.windows) {
            if (store.client.loadingNotifications == true) {
              Timer.periodic(const Duration(minutes: 10), (value) {
                store.getNotificationsBd();
              });
            }
          }
        }
      },
    );
  }

  @override
  void initState() {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      store.client.setOpen(true);
    }
    tz.initializeTimeZones();
    sendNotification();
    super.initState();
  }

  void sendNotification() {
    // ignore: unused_local_variable
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
  }

  @override
  final HomeStore store = Modular.get();
  final drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    sendNotification();
    return LayoutBuilder(builder: (context, constraint) {
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
                      back: false,
                      etiquetaList: store.client.etiquetas,
                      tarefas: store.client.taskDio,
                      setValueSearch: store.client.setSearchValue,
                      changeFilterSearch: store.changeFilterSearchList,
                      client: store.client,
                      getDioFase: store.getDioFase,
                    )
                  : PreferredSize(
                      child: Container(),
                      preferredSize: const Size(0, 32),
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  store.clientCreate.cleanSave();
                  store.clientCreate.setEditar(false);
                  DialogButtom().showDialogCreate(
                    CreateWidget(
                      constraint: constraint.maxWidth,
                    ),
                    constraint.maxWidth,
                    context,
                    store.getDioFase(),
                  );
                },
                child: Icon(
                  Icons.add,
                  size: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                      ? 48
                      : 24,
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
              body: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
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
                                      constraint: constraint.maxWidth,
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
                                  constraint: constraint.maxWidth,
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
            return LandscapeWidget(
              constraint: constraint.maxWidth,
            );
          }
        },
      );
    });
  }
}
