import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class HeaderWidget extends StatelessWidget {
  final TarefaModel tarefa;
  const HeaderWidget({Key? key, required this.tarefa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            InputChip(
              disabledColor: Colors.green.shade100,
              label: Text(
                tarefa.etiqueta,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            for (var i = 0; i < tarefa.users!.length; i++)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatarWidget(
                    url: tarefa.users![i].urlImage.toString()),
              ),
            Text(
              tarefa.texto,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            tarefa.data,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
