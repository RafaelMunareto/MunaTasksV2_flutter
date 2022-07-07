import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/badgets_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card/card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card/tarefas_none_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/create_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/scrool_speed.dart';

class ListCardWidget extends StatefulWidget {
  final BadgetsModel badgets;
  const ListCardWidget({Key? key, required this.badgets}) : super(key: key);

  @override
  State<ListCardWidget> createState() => _ListCardWidgetState();
}

class _ListCardWidgetState extends State<ListCardWidget>
    with SingleTickerProviderStateMixin {
  final HomeStore store = Modular.get();
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 8),
          child: SizedBox(
            width: 375,
            height: MediaQuery.of(context).size.height * 0.95,
            child: Wrap(
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
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                              widget.badgets.name == "Prioritário"
                                  ? Container()
                                  : GestureDetector(
                                      child: const MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Icon(Icons.add)),
                                      onTap: () {
                                        store.clientCreate.cleanSave();
                                        store.clientCreate.cleanSubtarefa();
                                        store.clientCreate.setEditar(false);
                                        store.clientCreate.setFaseTarefa(
                                            ConvertIcon().badgetToFase(
                                                widget.badgets.name));
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
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.90,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: ScrollSpeed(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: widget.badgets.dados!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardWidget(
                                  tarefaDioModel: widget.badgets.dados![index],
                                  constraint: constraint.maxWidth,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
