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
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              InputChip(
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            tarefa.texto,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 25,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
