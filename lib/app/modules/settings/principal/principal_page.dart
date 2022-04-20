import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/principal/widgets/dialog_input_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/widgets/dropdown_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/widgets/list_settings_widget.dart';
import 'package:munatasks2/app/modules/settings/principal/widgets/theme_logout_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

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
            ),
            context,
          ),
        },
        child: const Icon(Icons.add),
      ),
      body: Observer(
        builder: (_) {
          return !store.finalize
              ? Padding(
                  padding: kIsWeb || Platform.isWindows
                      ? const EdgeInsets.all(16.0)
                      : const EdgeInsets.all(0),
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
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
                        return SizedBox(
                          width: withDevice,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              const ThemeLogoutWidget(),
                              Expanded(
                                flex: 1,
                                child: Card(
                                  color: store.isSwitched
                                      ? darkThemeData(context).iconTheme.color
                                      : lightThemeData(context).iconTheme.color,
                                  elevation: 4,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: const DropdownWidget(),
                                    ),
                                  ),
                                ),
                              ),
                              const ListSettingsWidget()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const Center(child: CircularProgressWidget());
        },
      ),
    );
  }
}
