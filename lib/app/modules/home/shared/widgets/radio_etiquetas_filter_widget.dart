import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class RadioEtiquetasFilterWidget extends StatefulWidget {
  final dynamic etiquetaList;
  final Function? setEtiquetaSave;
  final Function? changeFilterEtiquetaList;
  final Function? setEtiquetaSelection;
  final Function? setIcon;
  final Function? setColor;
  final bool create;
  const RadioEtiquetasFilterWidget(
      {Key? key,
      required this.etiquetaList,
      this.changeFilterEtiquetaList,
      this.setColor,
      this.setIcon,
      this.create = false,
      this.setEtiquetaSelection,
      this.setEtiquetaSave})
      : super(key: key);

  @override
  State<RadioEtiquetasFilterWidget> createState() =>
      _RadioEtiquetasFilterWidgetState();
}

class _RadioEtiquetasFilterWidgetState extends State<RadioEtiquetasFilterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animacaoOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.9)));
    _controller.forward();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: _buildAnimation,
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return FadeTransition(
      opacity: _animacaoOpacity,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Observer(
          builder: (_) {
            if (widget.etiquetaList!.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<EtiquetaModel> list = widget.etiquetaList!.data;
              if (widget.create == false) {
                var todos = EtiquetaModel(
                    color: 'black', icon: 57585, etiqueta: 'TODOS');
                if (!list
                    .map((e) => e.etiqueta.contains('TODOS'))
                    .contains(true)) {
                  list.insert(0, todos);
                }
              } else {
                var selecione = EtiquetaModel(
                    color: 'black', icon: 57585, etiqueta: 'Etiqueta');
                if (!list
                    .map((e) => e.etiqueta.contains('Etiqueta'))
                    .contains(true)) {
                  list.insert(0, selecione);
                }
              }

              return Wrap(
                runAlignment: WrapAlignment.spaceAround,
                spacing: 16,
                children: [
                  for (var index = 0; index < list.length; index++)
                    InputChip(
                      key: UniqueKey(),
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
                          if (widget.create == false) {
                            widget.setEtiquetaSelection!(list[index].etiqueta);
                            widget.changeFilterEtiquetaList!();
                            widget.setIcon!(list[index].icon);
                            widget.setColor!(list[index].color);
                          } else {
                            widget.setEtiquetaSave!(list[index]);
                          }
                          FocusScope.of(context).unfocus();
                          Modular.to.pop();
                        });
                      },
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
