import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class PrioridadeSelectionWidget extends StatefulWidget {
  final Function setPrioridadeSelection;
  final int prioridadeSelection;
  final TarefaDioModel? tarefaModel;
  final bool create;
  final Function? changePrioridadeList;
  const PrioridadeSelectionWidget(
      {Key? key,
      required this.setPrioridadeSelection,
      required this.prioridadeSelection,
      this.tarefaModel,
      this.changePrioridadeList,
      this.create = false})
      : super(key: key);

  @override
  State<PrioridadeSelectionWidget> createState() =>
      _PrioridadeSelectionWidgetState();
}

class _PrioridadeSelectionWidgetState extends State<PrioridadeSelectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final HomeStore store = Modular.get();
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
    List<dynamic> list = store.client.settings.prioridade ?? [];

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
                        key: ObjectKey(linha),
                        labelPadding: const EdgeInsets.all(2),
                        elevation: 8.0,
                        avatar: linha == 4
                            ? const Icon(Icons.flag_outlined,
                                color: Colors.grey)
                            : Icon(
                                Icons.flag,
                                color: ConvertIcon().convertColorFlaf(linha),
                              ),
                        label: SizedBox(
                          width: constraint.maxWidth >
                                  LarguraLayoutBuilder().larguraModal
                              ? MediaQuery.of(context).size.width * 0.1
                              : MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            linha == 4
                                ? 'Normal'
                                : 'Prioridade ' + linha.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.setPrioridadeSelection(linha);
                            if (!widget.create) {
                              widget.changePrioridadeList!(widget.tarefaModel!);
                            }
                            FocusScope.of(context).unfocus();
                            Modular.to.pop();
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
