// ignore_for_file: unrelated_type_equality_checks

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
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import 'package:show_update_dialog/show_update_dialog.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

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
  bool appVisible = false;
  String? version = '';
  String? storeVersion = '';
  String? storeUrl = '';
  String? packageName = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        if (defaultTargetPlatform == Platform.isWindows &&
            store.client.checkUpdateDesktop) {
          checkUpdateDesktop();
        }
      },
    );
  }

  verifyVersion() async {
    final versionCheck = ShowUpdateDialog(
        androidId: 'munacorp.munatasks2.br.munatasks2',
        iOSAppStoreCountry: 'BR');

    final VersionModel vs = await versionCheck.fetchVersionInfo();
    var _releaseNotes = vs.releaseNotes!.replaceAll("<br>", "\n");
    versionCheck.showCustomDialogUpdate(
      context: context,
      versionStatus: vs,
      buttonText: "Atualizar",
      buttonColor: store.client.theme
          ? darkThemeData(context).primaryColor
          : lightThemeData(context).primaryColor,
      bodyoverride: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.update,
                  size: 150,
                  color: store.client.theme
                      ? darkThemeData(context).primaryColor
                      : lightThemeData(context).primaryColor,
                ),
              ],
            ),
            const Text(
              "Por favor atualize seu App.",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            Text(
              "Versão do aparelho: ${vs.localVersion}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "Versão da loja: ${vs.storeVersion}",
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 30),
            Text(
              _releaseNotes,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    store.buscaTheme(context);

    tz.initializeTimeZones();
    sendNotification();
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      verifyVersion();
    }
  }

  void sendNotification() {
    // ignore: unused_local_variable
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
  }

  @override
  Widget build(BuildContext context) {
    sendNotification();
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
                        setValueSearch: store.client.setSearchValue,
                        changeFilterSearch: store.changeFilterSearchList,
                        client: store.client,
                        getDioFase: store.getDioFase,
                        getPass: store.getPass,
                        closeSearch: store.client.closeSearch,
                        setCloseSearch: store.client.setCloseSearch,
                      )
                    : PreferredSize(
                        child: Container(),
                        preferredSize: const Size(0, 32),
                      ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    store.clientCreate.cleanSave();
                    store.clientCreate.cleanSubtarefa();
                    store.clientCreate.setEditar(false);
                    DialogButtom().showDialogCreate(
                      const CreateWidget(),
                      constraint.maxWidth,
                      context,
                      store.changeFilterUserList,
                    );
                  },
                  child: Icon(
                    Icons.add,
                    size: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                        ? 48
                        : 24,
                  ),
                ),
                // floatingActionButtonLocation:
                //     FloatingActionButtonLocation.endDocked,
                // bottomNavigationBar: Observer(builder: (_) {
                //   return NavigationBarWidget(
                //     theme: store.client.theme,
                //     navigateBarSelection: store.client.navigateBarSelection,
                //     setNavigateBarSelection: store.setNavigateBarSelection,
                //   );
                // }),
                body: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                    ? Observer(
                        builder: (_) {
                          return store.client.loading
                              ? const Scaffold(
                                  body: Center(child: CircularProgressWidget()),
                                )
                              : Row(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: MenuScreen(
                                        constraint: constraint.maxWidth,
                                        open: store.client.open,
                                        setOpen: store.client.setOpen,
                                        controller: drawerController,
                                        version: store.client.version,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: BodyHomePageWidget(
                                        constraint: constraint.maxWidth,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: BodyHomePageWidget(
                                        constraint: constraint.maxWidth,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: BodyHomePageWidget(
                                        constraint: constraint.maxWidth,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: SizedBox(
                                        width: 24,
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
                        mainScreen:
                            BodyHomePageWidget(constraint: constraint.maxWidth),
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
            return LandscapeWidget(
              constraint: constraint.maxWidth,
              theme: store.client.theme,
            );
          }
        },
      );
    });
  }

  checkUpdateDesktop() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 200,
          height: 200,
          child: AlertDialog(
            title: Text(
              'Atualizar versão',
              style: TextStyle(
                  color: store.client.theme
                      ? darkThemeData(context).primaryColor
                      : lightThemeData(context).primaryColor),
            ),
            content: Text(
              'Sua versão está desatualizada a nova versão é a ${store.client.version}',
            ),
            actions: [
              ElevatedButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text('Cancelar')),
              ElevatedButton(
                  onPressed: () => launchUrl(Uri.parse(
                      'https://github.com/RafaelMunareto/MunaTasksV2_flutter/raw/main/assets/exe/Output/munatask.exe')),
                  child: const Text('Atualizar')),
            ],
          ),
        );
      },
    );
  }
}
