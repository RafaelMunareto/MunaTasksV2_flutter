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

class _HomePageState extends ModularState<HomePage, HomeStore>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> opacidade;

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
        return GestureDetector(
          child: NavigationBarWidget(
              key: UniqueKey(),
              theme: store.theme,
              controller: _controller,
              navigateBarSelection: store.navigateBarSelection,
              setNavigateBarSelection: store.setNavigateBarSelection,
              badgets: store.badgetNavigate),
        );
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
                      theme: store.theme,
                      navigateBarSelection: store.navigateBarSelection,
                      opacidade: opacidade,
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
