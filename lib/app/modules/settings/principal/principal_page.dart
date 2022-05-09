import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/widgets/check_email_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';

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
        body: Observer(
          builder: (_) {
            return !store.client.finalize
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Center(
                        child: SizedBox(
                          width: withDevice,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              store.client.settingsUser.user != ''
                                  ? Expanded(
                                      child: CheckEmailWidget(
                                        constraint: constraint.maxWidth,
                                      ),
                                    )
                                  : Expanded(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: const Center(
                                            child: CircularProgressWidget()),
                                      ),
                                    ),
                            ],
                          ),
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
