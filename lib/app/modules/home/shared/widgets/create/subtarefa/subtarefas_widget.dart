import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/list_subtarefa_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class SubtarefasWidget extends StatefulWidget {
  final TextEditingController controller;
  const SubtarefasWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<SubtarefasWidget> createState() => _SubtarefasWidgetState();
}

class _SubtarefasWidgetState extends State<SubtarefasWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: store.client.theme
                ? darkThemeData(context).scaffoldBackgroundColor
                : lightThemeData(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: ListSubtarefaWidget(
                    tipo: 'pause',
                    controller: widget.controller,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ListSubtarefaWidget(
                    tipo: 'play',
                    controller: widget.controller,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ListSubtarefaWidget(
                    tipo: 'check',
                    controller: widget.controller,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
