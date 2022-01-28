import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';

class RetardActionWidget extends StatefulWidget {
  final Function updateDate;
  final dynamic retard;
  final int retardSelection;
  final Function setRetardSelection;
  final TarefaModel model;
  const RetardActionWidget({
    Key? key,
    required this.retard,
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
            if (widget.retard!.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<RetardModel> list = widget.retard!.data;
              return Wrap(
                runAlignment: WrapAlignment.spaceAround,
                spacing: 20,
                children: [
                  for (var index = 0; index < list.length; index++)
                    InputChip(
                      key: ObjectKey(list[index].reference),
                      labelPadding: const EdgeInsets.all(2),
                      elevation: 4.0,
                      avatar: const Icon(Icons.more_time_rounded),
                      label: SizedBox(
                        child: Text(
                          list[index].tempoName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.setRetardSelection(list[index].tempoValue);
                          Modular.to.pop();
                          widget.updateDate(widget.model);
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
