import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/fase_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class ActionsFaseWidget extends StatefulWidget {
  final Function setActionsFase;
  final dynamic faseList;
  const ActionsFaseWidget({
    Key? key,
    required this.setActionsFase,
    required this.faseList,
  }) : super(key: key);

  @override
  State<ActionsFaseWidget> createState() => _ActionsFaseWidgetState();
}

class _ActionsFaseWidgetState extends State<ActionsFaseWidget>
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
              if (store.client.settings.fase!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<dynamic>? list = store.client.settings.fase ?? [];
                return SingleChildScrollView(
                  child: Wrap(
                    runAlignment: WrapAlignment.center,
                    spacing: 24,
                    children: [
                      for (var linha in list)
                        Padding(
                          padding: kIsWeb
                              ? const EdgeInsets.only(bottom: 16.0)
                              : const EdgeInsets.only(bottom: 4.0),
                          child: InputChip(
                            key: ObjectKey(linha.id),
                            labelPadding: const EdgeInsets.all(2),
                            elevation: 8.0,
                            backgroundColor:
                                ConvertIcon().colorStatus(linha.status),
                            avatar: Icon(
                              IconData(linha.icon, fontFamily: 'MaterialIcons'),
                              color:
                                  ConvertIcon().convertColorFase(linha.color),
                            ),
                            label: SizedBox(
                              width: kIsWeb
                                  ? 100
                                  : MediaQuery.of(context).size.width,
                              child: Text(
                                linha.name.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: ConvertIcon()
                                      .colorStatusDark(linha.status),
                                ),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                widget.setActionsFase(linha.status);
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
