import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class SubItemWidget extends StatelessWidget {
  final SubtarefaModel subTarefa;
  final bool theme;

  const SubItemWidget({Key? key, required this.subTarefa, required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: theme ? Colors.black38 : Colors.black12,
            borderRadius: BorderRadius.circular(4)),
        child: ExpansionTile(
          key: UniqueKey(),
          title: ListTile(
            leading: SizedBox(
              width: 100,
              child: Text(
                subTarefa.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Icon(
              ConvertIcon().iconStatus(subTarefa.status),
              color: ConvertIcon().iconStatusColor(subTarefa.status),
            ),
            trailing: CircleAvatarWidget(url: subTarefa.user.urlImage),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                subTarefa.texto,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
