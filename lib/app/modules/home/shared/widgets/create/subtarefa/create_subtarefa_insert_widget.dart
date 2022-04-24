import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class CreateSubtarefaInsertWidget extends StatefulWidget {
  final dynamic subtarefaInserSelection;
  final Function setSubtarefaSelection;
  const CreateSubtarefaInsertWidget({
    Key? key,
    required this.subtarefaInserSelection,
    required this.setSubtarefaSelection,
  }) : super(key: key);

  @override
  State<CreateSubtarefaInsertWidget> createState() =>
      _CreateSubtarefaInsertWidgetState();
}

class _CreateSubtarefaInsertWidgetState
    extends State<CreateSubtarefaInsertWidget>
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
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.9),
      ),
    );
    _controller.forward();
    return AnimatedBuilder(
      animation: _controller,
      builder: _buildAnimation,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return FadeTransition(
      opacity: _animacaoOpacity,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Observer(
              builder: (_) {
                if (store.client.settings.subtarefaInsert!.isEmpty) {
                  return const Center(
                    child: CircularProgressWidget(),
                  );
                } else {
                  List<dynamic> list = [];
                  var selecione = 'Subtarefa';
                  if (!list
                      .map((e) => e.subtarefa.contains('Subtarefa'))
                      .contains(true)) {
                    list.insert(0, selecione);
                  }

                  return LayoutBuilder(builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: Wrap(
                        runAlignment: WrapAlignment.spaceAround,
                        spacing: 24,
                        children: [
                          for (var linha
                              in store.client.settings.subtarefaInsert!)
                            Padding(
                              padding: constraint.maxWidth >=
                                      LarguraLayoutBuilder().telaPc
                                  ? const EdgeInsets.only(bottom: 16.0)
                                  : const EdgeInsets.only(bottom: 4.0),
                              child: InputChip(
                                key: UniqueKey(),
                                labelPadding: const EdgeInsets.all(2),
                                elevation: 4.0,
                                avatar: const Icon(
                                  Icons.work,
                                  color: Colors.grey,
                                ),
                                label: SizedBox(
                                  width: 100,
                                  child: Text(
                                    linha,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.setSubtarefaSelection(linha);
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
      ),
    );
  }
}
