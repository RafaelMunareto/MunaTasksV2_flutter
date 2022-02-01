import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/create_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/navigation_bar_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_order_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/teams_selection_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
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
  late AnimationController createController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    createController = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    createController.dispose();
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

    order() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ordenamento'),
            actions: [
              TextButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: const Text('OK'),
              ),
            ],
            content: Observer(builder: (_) {
              return RadioOrderWidget(
                  orderAscDesc: store.client.orderAscDesc,
                  setOrderAscDesc: store.client.setOrderAscDesc,
                  orderList: store.client.orderList,
                  orderSelection: store.client.orderSelection,
                  changeOrderList: store.changeOrderList,
                  setOrderSelection: store.client.setOrderSelection);
            }),
          );
        },
      );
    }

    etiquetas() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Etiquetas'),
            content: Observer(
              builder: (_) {
                return RadioEtiquetasFilterWidget(
                  changeFilterEtiquetaList: store.changeFilterEtiquetaList,
                  etiquetaList: store.client.etiquetaList,
                  setColor: store.client.setColor,
                  setIcon: store.client.setIcon,
                  setEtiquetaSelection: store.client.setEtiquetaSelection,
                );
              },
            ),
          );
        },
      );
    }

    teams() {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Equipe'),
            content: Observer(
              builder: (_) {
                return TeamsSelectionWidget(
                  changeFilterUserList: store.changeFilterUserList,
                  userLista: store.client.userList,
                  setImageUser: store.client.setImgUrl,
                  setUserSelection: store.client.setUserSelection,
                );
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBarWidget(
        icon: Icons.bookmark,
        home: true,
        context: context,
        zoomController: drawerController,
        setOpen: store.client.setOpen,
        settings: true,
        back: false,
        etiquetaList: store.client.tarefas,
        tarefas: store.client.tarefas,
        setValueSearch: store.client.setSearchValue,
        etiquetaSelection: store.client.etiquetaSelection,
        setEtiquetaSelection: store.client.setEtiquetaSelection,
        changeFilterSearch: store.changeFilterSearchList,
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
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Observer(builder: (_) {
        return NavigationBarWidget(
            theme: store.client.theme,
            navigateBarSelection: store.client.navigateBarSelection,
            setNavigateBarSelection: store.setNavigateBarSelection,
            badgets: store.client.badgetNavigate);
      }),
      body: ZoomDrawer(
        controller: drawerController,
        style: DrawerStyle.Style1,
        menuScreen: Observer(
          builder: (_) {
            return MenuScreen(
              open: store.client.open,
              setOpen: store.client.setOpen,
              controller: drawerController,
            );
          },
        ),
        mainScreen: Observer(builder: (_) {
          return !store.client.loading
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            leading: GestureDetector(
                              child: store.client.icon != 0
                                  ? Icon(
                                      IconData(store.client.icon,
                                          fontFamily: 'MaterialIcons'),
                                      color: ConvertIcon()
                                          .convertColor(store.client.color),
                                    )
                                  : const Icon(Icons.bookmark),
                              onTap: () {
                                etiquetas();
                              },
                            ),
                            title: Center(
                              child: GestureDetector(
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.filter_alt,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        store.client.orderAscDesc
                                            ? '${store.client.orderSelection} DESC'
                                            : '${store.client.orderSelection} ASC',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () => order(),
                              ),
                            ),
                            trailing: GestureDetector(
                              child: CircleAvatarWidget(
                                url: store.client.imgUrl,
                              ),
                              onTap: () {
                                if (store.client.perfilUserLogado.manager) {
                                  teams();
                                }
                              },
                            ),
                          ),
                          CreateWidget(
                            controller: createController,
                          ),
                          SingleChildScrollView(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.62,
                              child: store.client.loading
                                  ? const CircularProgressIndicator()
                                  : CardWidget(
                                      opacidade: opacidade,
                                    ),
                            ),
                          ),
                        ],
                      ),
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
