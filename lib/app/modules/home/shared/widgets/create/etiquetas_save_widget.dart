import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class EtiquetasSaveWidget extends StatefulWidget {
  const EtiquetasSaveWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<EtiquetasSaveWidget> createState() => _EtiquetasSaveWidgetState();
}

class _EtiquetasSaveWidgetState extends State<EtiquetasSaveWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return GestureDetector(
        child: Observer(builder: (_) {
          return Chip(
            label: Text(
              store.clientCreate.tarefaModelSaveEtiqueta.icon != null
                  ? store.clientCreate.tarefaModelSaveEtiqueta.etiqueta
                  : 'Etiqueta',
              style: TextStyle(
                fontSize: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                    ? 14
                    : 10,
              ),
            ),
            avatar: Icon(
              store.clientCreate.tarefaModelSaveEtiqueta.icon != null
                  ? IconData(
                      store.clientCreate.tarefaModelSaveEtiqueta.icon ?? 0,
                      fontFamily: 'MaterialIcons')
                  : Icons.bookmark,
              color: ConvertIcon().convertColor(
                store.clientCreate.tarefaModelSaveEtiqueta.color,
              ),
            ),
          );
        }),
        onTap: () {
          DialogButtom().showDialog(
            const RadioEtiquetasFilterWidget(
              create: true,
            ),
            store.client.theme,
            constraint.maxWidth,
            context,
          );
        },
      );
    });
  }
}
