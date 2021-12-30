import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class SubItemWidget extends StatelessWidget {
  final SubtarefaModel subTarefa;

  const SubItemWidget({Key? key, required this.subTarefa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            ListTile(
              leading: SizedBox(
                  width: 100,
                  child: Text(
                    subTarefa.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
              title: Icon(
                ConvertIcon().iconStatus(subTarefa.status),
                color: kPrimaryColor,
              ),
              trailing:
                  CircleAvatarWidget(url: subTarefa.user!.photoURL.toString()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                subTarefa.texto,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
