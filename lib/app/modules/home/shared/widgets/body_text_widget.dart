import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/sub_item_widget.dart';

class BodyTextWidget extends StatelessWidget {
  final TarefaModel tarefa;

  const BodyTextWidget({Key? key, required this.tarefa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Text(
              tarefa.texto,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 20,
            ),
          ),
        ),
        for (var i = 0; i < tarefa.subTarefa!.length; i++)
          SubItemWidget(subTarefa: tarefa.subTarefa![i]),
      ],
    );
  }
}
