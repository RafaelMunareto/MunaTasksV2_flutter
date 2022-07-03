import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card/card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card/tarefas_none_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/create_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class ListCardWidget extends StatefulWidget {
  final dynamic color;
  final dynamic title;
  const ListCardWidget({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  State<ListCardWidget> createState() => _ListCardWidgetState();
}

class _ListCardWidgetState extends State<ListCardWidget>
    with SingleTickerProviderStateMixin {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return store.client.loading
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8),
              child: LayoutBuilder(builder: (context, constraint) {
                return Observer(
                  builder: (_) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipPath(
                              clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        color: widget.color, width: 15),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            widget.title,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Badge(
                                            toAnimate: false,
                                            shape: BadgeShape.square,
                                            badgeColor: widget.color,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            badgeContent: Text('10',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        child: const MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Icon(Icons.add)),
                                        onTap: () {
                                          store.clientCreate.cleanSave();
                                          store.clientCreate.cleanSubtarefa();
                                          store.clientCreate.setEditar(false);
                                          DialogButtom().showDialogCreate(
                                            const CreateWidget(),
                                            constraint.maxWidth,
                                            context,
                                            store.changeFilterUserList,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          key: UniqueKey(),
                          flex: 1,
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: store.client.taskDioSearch.isEmpty
                                ? TarefasNoneWidget(theme: store.client.theme)
                                : ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    controller: ScrollController(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(4),
                                    itemCount:
                                        store.client.taskDioSearch.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CardWidget(
                                        tarefaDioModel:
                                            store.client.taskDioSearch[index],
                                        constraint: constraint.maxWidth,
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            );
    });
  }
}
