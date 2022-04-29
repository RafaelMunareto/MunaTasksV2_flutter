import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class SubItemSaveWidget extends StatefulWidget {
  final bool theme;
  final dynamic subtarefa;
  const SubItemSaveWidget(
      {Key? key, required this.theme, required this.subtarefa})
      : super(key: key);

  @override
  State<SubItemSaveWidget> createState() => _SubItemSaveWidgetState();
}

class _SubItemSaveWidgetState extends State<SubItemSaveWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: widget.theme ? Colors.black38 : Colors.black12,
                borderRadius: BorderRadius.circular(4)),
            child: ExpansionTile(
              key: UniqueKey(),
              title: constraint.maxWidth > LarguraLayoutBuilder().larguraModal
                  ? ListTile(
                      leading: SizedBox(
                        child: Text(
                          widget.subtarefa.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Icon(
                        ConvertIcon().iconStatus(widget.subtarefa.status),
                        color: ConvertIcon()
                            .iconStatusColor(widget.subtarefa.status),
                      ),
                      trailing: CircleAvatarWidget(
                          url: widget.subtarefa.user.urlImage),
                    )
                  : Wrap(
                      children: [
                        ListTile(
                          title: SizedBox(
                            child: Text(
                              widget.subtarefa.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            ConvertIcon().iconStatus(widget.subtarefa.status),
                            color: ConvertIcon()
                                .iconStatusColor(widget.subtarefa.status),
                          ),
                          trailing: CircleAvatarWidget(
                              url: widget.subtarefa.user.urlImage),
                        ),
                      ],
                    ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.subtarefa.texto,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
