import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class ColorsWidget extends StatefulWidget {
  const ColorsWidget({Key? key}) : super(key: key);

  @override
  State<ColorsWidget> createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget> {
  final EtiquetasStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
            ? MediaQuery.of(context).size.height * 0.4
            : MediaQuery.of(context).size.height * 0.5,
        child: Observer(
          builder: (_) {
            if (store.etiquetaStore.colorsDio.isEmpty) {
              return const Center(
                child: CircularProgressWidget(),
              );
            } else {
              List list = store.etiquetaStore.colorsDio;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) {
                  var model = list[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          ConvertIcon().convertColorName(model).toString(),
                          style: TextStyle(
                              color: ConvertIcon().convertColor(model)),
                        ),
                        leading: Radio(
                          value: model.toString(),
                          groupValue: store.etiquetaStore.color,
                          activeColor: ConvertIcon().convertColor(model),
                          onChanged: (value) {
                            setState(() {
                              store.etiquetaStore.setColor(value);
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      );
    });
  }
}
