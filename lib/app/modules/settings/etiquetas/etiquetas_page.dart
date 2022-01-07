import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';

class EtiquetasPage extends StatefulWidget {
  final String title;
  const EtiquetasPage({Key? key, this.title = 'Etiquetas'}) : super(key: key);
  @override
  EtiquetasPageState createState() => EtiquetasPageState();
}

class EtiquetasPageState extends State<EtiquetasPage> {
  final EtiquetasStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          icon: Icons.bookmark,
          context: context,
          settings: true,
          rota: '/home'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(builder: (context, constraint) {
          double withDevice = constraint.maxWidth;

          if (withDevice < 600) {
            withDevice = withDevice * 1;
          } else if (withDevice < 960) {
            withDevice = withDevice * 0.7;
          } else if (withDevice < 1025) {
            withDevice = withDevice * 0.5;
          } else {
            withDevice = withDevice * 0.4;
          }
          return SizedBox(
            width: withDevice,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
            ),
          );
        }),
      ),
    );
  }
}
