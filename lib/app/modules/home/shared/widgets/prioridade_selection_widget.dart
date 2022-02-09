import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/shared/model/prioridade_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class PrioridadeSelectionWidget extends StatefulWidget {
  final dynamic prioridadeList;
  final Function setPrioridadeSelection;
  final int prioridadeSelection;
  final TarefaModel? tarefaModel;
  final bool create;
  final Function? changePrioridadeList;
  const PrioridadeSelectionWidget(
      {Key? key,
      required this.prioridadeList,
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Observer(
            builder: (_) {
              if (widget.prioridadeList!.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<PrioridadeModel> list = widget.prioridadeList!.data;
                return SingleChildScrollView(
                  child: Wrap(
                    runAlignment: WrapAlignment.spaceAround,
                    spacing: 24,
                    children: [
                      for (var index = 0; index < list.length; index++)
                        Padding(
                          padding: kIsWeb
                              ? const EdgeInsets.only(bottom: 16.0)
                              : const EdgeInsets.only(bottom: 8.0),
                          child: InputChip(
                            key: ObjectKey(list[index].reference),
                            labelPadding: const EdgeInsets.all(2),
                            elevation: 8.0,
                            avatar: list[index].prioridade == 4
                                ? const Icon(Icons.flag_outlined,
                                    color: Colors.grey)
                                : Icon(
                                    Icons.flag,
                                    color: ConvertIcon().convertColorFlaf(
                                        list[index].prioridade),
                                  ),
                            label: SizedBox(
                              width: kIsWeb
                                  ? 100
                                  : MediaQuery.of(context).size.width,
                              child: Text(
                                list[index].prioridade == 4
                                    ? 'Normal'
                                    : 'Prioridade ' +
                                        list[index].prioridade.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                widget.setPrioridadeSelection(
                                    list[index].prioridade);
                                if (!widget.create) {
                                  widget.changePrioridadeList!(
                                      widget.tarefaModel!);
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
              }
            },
          ),
        ),
      ),
    );
  }
}
