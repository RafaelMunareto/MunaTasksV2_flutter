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
      return widget.subtarefa == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.theme ? Colors.black38 : Colors.black12,
                      borderRadius: BorderRadius.circular(4)),
                  child: Wrap(
                    children: [
                      constraint.maxWidth > LarguraLayoutBuilder().larguraModal
                          ? ListTile(
                              leading: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                                child: Text(
                                  widget.subtarefa.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: widget.theme
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                              ),
                              title: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Icon(
                                  ConvertIcon()
                                      .iconStatus(widget.subtarefa.status),
                                  color: ConvertIcon()
                                      .iconStatusColor(widget.subtarefa.status),
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: CircleAvatarWidget(
                                    nameUser: widget.subtarefa.user.name.name,
                                    url: widget.subtarefa.user.urlImage),
                              ),
                            )
                          : Wrap(
                              children: [
                                ListTile(
                                  leading: SizedBox(
                                    child: Text(
                                      widget.subtarefa.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  title: Icon(
                                    ConvertIcon()
                                        .iconStatus(widget.subtarefa.status),
                                    color: ConvertIcon().iconStatusColor(
                                        widget.subtarefa.status),
                                  ),
                                  trailing: CircleAvatarWidget(
                                      nameUser: widget.subtarefa.user.name.name,
                                      url: widget.subtarefa.user.urlImage),
                                ),
                              ],
                            ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                          child: Text(
                            widget.subtarefa.texto,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 12),
                          ),
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
