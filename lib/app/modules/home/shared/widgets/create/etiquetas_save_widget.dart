import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class EtiquetasSaveWidget extends StatefulWidget {
  final double constraint;
  const EtiquetasSaveWidget({
    Key? key,
    required this.constraint,
  }) : super(key: key);

  @override
  State<EtiquetasSaveWidget> createState() => _EtiquetasSaveWidgetState();
}

class _EtiquetasSaveWidgetState extends State<EtiquetasSaveWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Observer(builder: (_) {
      return widget.constraint < LarguraLayoutBuilder().telaPc
          ? Icon(
              store.clientCreate.tarefaModelSaveEtiqueta.icon != null
                  ? IconData(
                      store.clientCreate.tarefaModelSaveEtiqueta.icon ?? 0,
                      fontFamily: 'MaterialIcons')
                  : Icons.bookmark,
              color: ConvertIcon().convertColor(
                store.clientCreate.tarefaModelSaveEtiqueta.color,
              ),
            )
          : Chip(
              label: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  store.clientCreate.tarefaModelSaveEtiqueta.etiqueta == 'TODOS'
                      ? 'Etiqueta'
                      : store.clientCreate.tarefaModelSaveEtiqueta.icon != null
                          ? store.clientCreate.tarefaModelSaveEtiqueta.etiqueta
                          : 'Etiqueta',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:
                        widget.constraint > LarguraLayoutBuilder().larguraModal
                            ? 12
                            : 10,
                  ),
                ),
              ),
              avatar: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  store.clientCreate.tarefaModelSaveEtiqueta.icon != null
                      ? IconData(
                          store.clientCreate.tarefaModelSaveEtiqueta.icon ?? 0,
                          fontFamily: 'MaterialIcons')
                      : Icons.bookmark,
                  color: ConvertIcon().convertColor(
                    store.clientCreate.tarefaModelSaveEtiqueta.color,
                  ),
                ),
              ),
            );
    }), onTap: () {
      DialogButtom().showDialog(
        const RadioEtiquetasFilterWidget(
          create: true,
        ),
        store.client.theme,
        widget.constraint,
        context,
      );
    });
  }
}
