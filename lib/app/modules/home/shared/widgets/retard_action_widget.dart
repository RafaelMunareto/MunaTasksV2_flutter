import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/retard_dio_model.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class RetardActionWidget extends StatefulWidget {
  final Function updateDate;
  final int retardSelection;
  final Function setRetardSelection;
  final TarefaDioModel model;
  const RetardActionWidget({
    Key? key,
    required this.updateDate,
    required this.retardSelection,
    required this.setRetardSelection,
    required this.model,
  }) : super(key: key);

  @override
  State<RetardActionWidget> createState() => _RetardActionWidgetState();
}

class _RetardActionWidgetState extends State<RetardActionWidget>
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
    List<RetardDioModel>? list = store.client.retard;
    return FadeTransition(
      opacity: _animacaoOpacity,
      child: LayoutBuilder(builder: (context, constraint) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Wrap(
                runAlignment: WrapAlignment.spaceAround,
                spacing: 24,
                children: [
                  for (var linha in list)
                    Padding(
                      padding: constraint.maxWidth >
                              LarguraLayoutBuilder().larguraModal
                          ? const EdgeInsets.only(bottom: 16.0)
                          : const EdgeInsets.only(bottom: 16.0),
                      child: InputChip(
                        key: UniqueKey(),
                        labelPadding: const EdgeInsets.all(2),
                        elevation: 4.0,
                        avatar: const Icon(Icons.more_time_rounded),
                        label: SizedBox(
                          width: 100,
                          child: Text(
                            linha.tempoName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.setRetardSelection(linha.tempoValue);
                            Modular.to.pop();
                            FocusScope.of(context).requestFocus(FocusNode());
                            widget.updateDate(widget.model);
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
