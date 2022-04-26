import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/app_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/principal/widgets/dialog_input_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/widgets/dropdown_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/widgets/list_settings_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import 'package:rolling_switch/rolling_switch.dart';

class PrincipalPage extends StatefulWidget {
  final String title;
  const PrincipalPage({Key? key, this.title = 'Configurações'})
      : super(key: key);
  @override
  PrincipalPageState createState() => PrincipalPageState();
}

class PrincipalPageState extends State<PrincipalPage>
    with SingleTickerProviderStateMixin {
  final PrincipalStore store = Modular.get();
  late Animation<double> opacidade;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      double withDevice = constraint.maxWidth;

      if (withDevice < 600) {
        withDevice = withDevice * 1;
      } else if (withDevice < 960) {
        withDevice = withDevice * 0.7;
      } else if (withDevice < 1025) {
        withDevice = withDevice * 0.5;
      } else {
        withDevice = withDevice * 0.5;
      }
      return Scaffold(
        appBar: AppBarWidget(
            title: widget.title,
            icon: Icons.settings,
            context: context,
            settings: true,
            rota: '/home/'),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          onPressed: () => {
            DialogButtom().showDialog(
              DialogInputWidget(
                value: '',
                create: 'Novo',
                editar: store.novo,
                constraint: constraint.maxWidth,
              ),
              store.isSwitched,
              constraint.maxWidth,
              context,
            ),
          },
          child: const Icon(Icons.add),
        ),
        body: Observer(
          builder: (_) {
            return !store.finalize
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: SizedBox(
                        width: withDevice,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 50,
                              child: ListTile(
                                title: const Text('TEMA'),
                                trailing: RollingSwitch.icon(
                                  initialState: store.isSwitched,
                                  animationDuration:
                                      const Duration(milliseconds: 600),
                                  onChanged: (bool state) {
                                    setState(() {
                                      AppWidget.of(context)!.changeTheme(state
                                          ? ThemeMode.dark
                                          : ThemeMode.light);
                                      store.changeSwitch(state);
                                    });
                                  },
                                  rollingInfoRight: RollingIconInfo(
                                    backgroundColor: store.isSwitched
                                        ? darkThemeData(context).primaryColor
                                        : lightThemeData(context).primaryColor,
                                    icon: Icons.nights_stay,
                                    text: const Text(
                                      'Dark',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  rollingInfoLeft: const RollingIconInfo(
                                    backgroundColor: Colors.amber,
                                    icon: Icons.wb_sunny,
                                    text: Text(
                                      'Light',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 50,
                              child: ListTile(
                                title: const Text('LOGOUT'),
                                trailing: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      store.isSwitched
                                          ? darkThemeData(context).primaryColor
                                          : lightThemeData(context)
                                              .primaryColor,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        side: BorderSide(
                                          color: store.isSwitched
                                              ? darkThemeData(context)
                                                  .primaryColor
                                              : lightThemeData(context)
                                                  .primaryColor,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    store.logoff();
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 12, 16, 12),
                                    child: Text('Sair',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: store.isSwitched
                                              ? darkThemeData(context)
                                                  .scaffoldBackgroundColor
                                              : lightThemeData(context)
                                                  .scaffoldBackgroundColor,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 50,
                              child: Card(
                                color: store.isSwitched
                                    ? darkThemeData(context).iconTheme.color
                                    : lightThemeData(context).iconTheme.color,
                                elevation: 4,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: const DropdownWidget(),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 400,
                              child: ListSettingsWidget(
                                  constraint: constraint.maxWidth),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(child: CircularProgressWidget());
          },
        ),
      );
    });
  }
}
