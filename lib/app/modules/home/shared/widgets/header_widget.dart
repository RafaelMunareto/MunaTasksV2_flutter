import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class HeaderWidget extends StatefulWidget {
  final dynamic tarefa;
  final bool theme;
  const HeaderWidget({Key? key, required this.tarefa, required this.theme})
      : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0, left: 8),
                child: Icon(
                  changeIconeAndColorTime(widget.tarefa.data)[1],
                  color: changeIconeAndColorTime(widget.tarefa.data)[0],
                  size: 18,
                ),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(widget.tarefa.data).toString(),
                style: TextStyle(
                    fontSize: 10,
                    color: store.client.theme ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.end,
              children: [
                for (var model in widget.tarefa.users!)
                  CircleAvatarWidget(
                    nameUser: model.name.name,
                    key: Key(model.id.toString()),
                    url: model.urlImage,
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  changeIconeAndColorTime(date) {
    DateTime now = DateTime.now();
    if (date.isAfter(now)) {
      return [Colors.blue, Icons.timelapse_sharp];
    } else if (date.day == now.day) {
      return [Colors.amber, Icons.alarm];
    } else {
      return [Colors.red, Icons.history];
    }
  }
}
