import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/badgets_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card/card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card/tarefas_none_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/create_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

class ListCardWidget extends StatefulWidget {
  final BadgetsModel badgets;
  const ListCardWidget({Key? key, required this.badgets}) : super(key: key);

  @override
  State<ListCardWidget> createState() => _ListCardWidgetState();
}

class _ListCardWidgetState extends State<ListCardWidget>
    with SingleTickerProviderStateMixin {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
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
                            color: widget.badgets.colors!, width: 15),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                widget.badgets.name,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Badge(
                                toAnimate: false,
                                shape: BadgeShape.square,
                                badgeColor: widget.badgets.colors!,
                                borderRadius: BorderRadius.circular(8),
                                badgeContent: Text(
                                    widget.badgets.qtd.toString(),
                                    style:
                                        const TextStyle(color: Colors.white)),
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
            widget.badgets.dados!.isEmpty
                ? TarefasNoneWidget(theme: store.client.theme)
                : Expanded(
                    key: UniqueKey(),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: ScrollController(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(4),
                      itemCount: widget.badgets.dados!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(.40),
                          child: CardWidget(
                            tarefaDioModel: widget.badgets.dados![index],
                            constraint: constraint.maxWidth,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}
