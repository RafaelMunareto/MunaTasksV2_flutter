import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class RadioEtiquetasFilterWidget extends StatefulWidget {
  final bool create;
  const RadioEtiquetasFilterWidget({
    Key? key,
    this.create = false,
  }) : super(key: key);

  @override
  State<RadioEtiquetasFilterWidget> createState() =>
      _RadioEtiquetasFilterWidgetState();
}

class _RadioEtiquetasFilterWidgetState extends State<RadioEtiquetasFilterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoOpacity;
  final HomeStore store = Modular.get();

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Observer(
            builder: (_) {
              if (store.client.etiquetas.isEmpty) {
                return const Center(
                  child: CircularProgressWidget(),
                );
              } else {
                List<EtiquetaDioModel> list = store.client.etiquetas;
                if (widget.create == false) {
                  var todos = EtiquetaDioModel(
                      color: 'blue', icon: 57585, etiqueta: 'TODOS');
                  if (!list
                      .map((e) => e.etiqueta.contains('TODOS'))
                      .contains(true)) {
                    list.insert(0, todos);
                  }
                }

                return LayoutBuilder(builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: Wrap(
                      runAlignment: WrapAlignment.spaceAround,
                      spacing: 24,
                      children: [
                        for (var index = 0; index < list.length; index++)
                          Padding(
                            padding: constraint.maxWidth >
                                    LarguraLayoutBuilder().larguraModal
                                ? const EdgeInsets.only(bottom: 16.0)
                                : const EdgeInsets.only(bottom: 16.0),
                            child: InputChip(
                              key: UniqueKey(),
                              labelPadding: const EdgeInsets.all(2),
                              elevation: 4.0,
                              avatar: Icon(
                                IconData(list[index].icon ?? 0,
                                    fontFamily: 'MaterialIcons'),
                                color: ConvertIcon()
                                    .convertColor(list[index].color),
                              ),
                              label: SizedBox(
                                width: 100,
                                child: Text(
                                  list[index].etiqueta,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (widget.create == false) {
                                    store.client
                                        .setEtiquetaSelection(list[index].icon);
                                    store.changeFilterEtiquetaList();
                                    store.client.setIcon(list[index].icon);
                                    store.client.setColor(list[index].color);
                                  } else {
                                    store.clientCreate
                                        .setSaveEtiqueta(list[index]);
                                  }
                                  FocusScope.of(context).unfocus();
                                  Modular.to.pop();
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
