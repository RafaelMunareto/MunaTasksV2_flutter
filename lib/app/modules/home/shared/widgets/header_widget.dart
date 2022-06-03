import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class HeaderWidget extends StatelessWidget {
  final dynamic tarefa;
  final bool theme;
  const HeaderWidget({Key? key, required this.tarefa, required this.theme})
      : super(key: key);

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
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                label: Text(
                  tarefa.etiqueta.etiqueta,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10),
                ),
                avatar: Icon(
                  IconData(tarefa.etiqueta.icon ?? 0,
                      fontFamily: 'MaterialIcons'),
                  color: ConvertIcon().convertColor(tarefa.etiqueta.color),
                ),
              ),
              Wrap(
                children: [
                  for (var i = 0; i < tarefa.users!.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatarWidget(
                        nameUser: tarefa.users![i].name.name,
                        key: Key(tarefa.users![i].id.toString()),
                        url: tarefa.users![i].urlImage,
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16, left: 16),
            child: Text(
              tarefa.texto,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: theme ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
