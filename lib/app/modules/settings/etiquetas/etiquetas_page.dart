import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/models/colors_model.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/text_field_widget.dart';

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
      body: Observer(builder: (_) {
        if (store.colorsList!.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (store.colorsList!.hasError) {
          return Center(
            child: ElevatedButton(
              onPressed: store.getColors,
              child: const Text('Error'),
            ),
          );
        } else {
          List<ColorsModel> list = store.colorsList!.data;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                var model = list[index];
                return Column(
                  children: [
                    Text(model.color.toString()),
                  ],
                );
              });
        }
      }),
    );
  }
}
