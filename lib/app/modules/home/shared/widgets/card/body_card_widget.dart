import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class BodyCardWidget extends StatefulWidget {
  final dynamic tarefa;
  final bool theme;
  final double constraints;
  const BodyCardWidget(
      {Key? key,
      required this.tarefa,
      required this.theme,
      required this.constraints})
      : super(key: key);

  @override
  State<BodyCardWidget> createState() => _BodyCardWidgetState();
}

class _BodyCardWidgetState extends State<BodyCardWidget> {
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
            child: Wrap(
              runSpacing: 4,
              spacing: 4,
              direction: Axis.horizontal,
              alignment: WrapAlignment.end,
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
