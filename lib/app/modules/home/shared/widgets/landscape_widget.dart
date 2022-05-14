import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_int_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';

class LandscapeWidget extends StatefulWidget {
  final double constraint;
  final bool theme;
  const LandscapeWidget(
      {Key? key, required this.constraint, required this.theme})
      : super(key: key);

  @override
  State<LandscapeWidget> createState() => _LandscapeWidgetState();
}

class _LandscapeWidgetState extends State<LandscapeWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return store.client.loadingTasksTotal
          ? const Center(child: SizedBox(child: CircularProgressWidget()))
          : Scaffold(
              body: LandscapeIntWidget(
                constraint: widget.constraint,
                theme: widget.theme,
              ),
            );
    });
  }
}
