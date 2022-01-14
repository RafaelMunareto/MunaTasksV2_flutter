import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class RadioEtiquetasFilterWidget extends StatefulWidget {
  final dynamic etiquetaList;
  final dynamic etiquetaSelection;
  final Function changeFilterEtiquetaList;
  final Function? setEtiquetaSelection;
  final Function setIcon;
  final Function setColor;
  final Function setClosedListExpanded;
  final bool closedListExpanded;
  const RadioEtiquetasFilterWidget(
      {Key? key,
      required this.etiquetaList,
      required this.etiquetaSelection,
      required this.changeFilterEtiquetaList,
      required this.setColor,
      required this.setIcon,
      required this.setClosedListExpanded,
      required this.closedListExpanded,
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
      height: MediaQuery.of(context).size.height * 0.40,
      child: Observer(
        builder: (_) {
          if (widget.etiquetaList!.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<EtiquetaModel> list = widget.etiquetaList!.data;
            var todos =
                EtiquetaModel(color: 'blue', icon: 57585, etiqueta: 'TODOS');
            if (!list.map((e) => e.etiqueta.contains('TODOS')).contains(true)) {
              list.insert(0, todos);
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                var model = list[index];
                return Center(
                  child: ListTile(
                    key: Key(model.etiqueta.toString()),
                    title: Text(
                      model.etiqueta,
                      style: TextStyle(
                        color: ConvertIcon().convertColor(model.color),
                      ),
                    ),
                    leading: Radio(
                      value: model.etiqueta,
                      groupValue: widget.etiquetaSelection,
                      onChanged: (value) {
                        setState(() {
                          widget.setEtiquetaSelection!(value);
                          widget.changeFilterEtiquetaList(value);
                          widget.setIcon(model.icon);
                          widget.setColor(model.color);
                          widget.setClosedListExpanded(
                              !widget.closedListExpanded);
                        });
                      },
                    ),
                    trailing: Icon(
                      IconData(model.icon ?? 0, fontFamily: 'MaterialIcons'),
                      color: ConvertIcon().convertColor(model.color),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
