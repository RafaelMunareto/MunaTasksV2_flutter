import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class RadioEtiquetasFilterWidget extends StatefulWidget {
  final dynamic etiquetaList;
  final Function changeFilterEtiquetaList;
  final Function? setEtiquetaSelection;
  final Function setIcon;
  final Function setColor;
  final Function setClosedListExpanded;
  const RadioEtiquetasFilterWidget(
      {Key? key,
      required this.etiquetaList,
      required this.changeFilterEtiquetaList,
      required this.setColor,
      required this.setIcon,
      required this.setClosedListExpanded,
      this.setEtiquetaSelection})
      : super(key: key);

  @override
  State<RadioEtiquetasFilterWidget> createState() =>
      _RadioEtiquetasFilterWidgetState();
}

class _RadioEtiquetasFilterWidgetState
    extends State<RadioEtiquetasFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Observer(
        builder: (_) {
          if (widget.etiquetaList!.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<EtiquetaModel> list = widget.etiquetaList!.data;
            var todos =
                EtiquetaModel(color: 'black', icon: 57585, etiqueta: 'TODOS');
            if (!list.map((e) => e.etiqueta.contains('TODOS')).contains(true)) {
              list.insert(0, todos);
            }
            return Wrap(
              runAlignment: WrapAlignment.spaceAround,
              spacing: 16,
              children: [
                for (var index = 0; index < list.length; index++)
                  InputChip(
                    key: ObjectKey(list[index].reference),
                    labelPadding: const EdgeInsets.all(2),
                    elevation: 4.0,
                    avatar: Icon(
                      IconData(list[index].icon ?? 0,
                          fontFamily: 'MaterialIcons'),
                      color: ConvertIcon().convertColor(list[index].color),
                    ),
                    label: SizedBox(
                      child: Text(
                        list[index].etiqueta,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.setEtiquetaSelection!(list[index].etiqueta);
                        widget.changeFilterEtiquetaList();
                        widget.setIcon(list[index].icon);
                        widget.setColor(list[index].color);
                        widget.setClosedListExpanded(true);
                      });
                    },
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
