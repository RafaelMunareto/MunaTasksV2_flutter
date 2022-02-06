import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

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
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: Observer(builder: (_) {
          return Chip(
            label: Text(
              store.clientCreate.tarefaModelSaveEtiqueta.icon != null
                  ? store.clientCreate.tarefaModelSaveEtiqueta.etiqueta
                  : 'Etiqueta',
              style: const TextStyle(fontSize: 12),
            ),
            avatar: Icon(
              store.clientCreate.tarefaModelSaveEtiqueta.icon != null
                  ? IconData(
                      store.clientCreate.tarefaModelSaveEtiqueta.icon ?? 0,
                      fontFamily: 'MaterialIcons')
                  : Icons.bookmark,
              color: ConvertIcon().convertColor(
                  store.clientCreate.tarefaModelSaveEtiqueta.color),
            ),
          );
        }),
      ),
      onTap: () {
        setState(() {
          DialogButtom().showDialog(
              RadioEtiquetasFilterWidget(
                etiquetaList: store.client.etiquetaList,
                create: true,
                setEtiquetaSave: store.clientCreate.setSaveEtiqueta,
              ),
              context);
        });
      },
    );
  }
}
