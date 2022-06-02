import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefas_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class SubItemWidget extends StatefulWidget {
  final SubtarefasDioModel subTarefa;
  final TarefaDioModel tarefaModel;
  final Function setSubtarefaModel;
  final List<String> subtarefaActionList;
  final bool theme;

  const SubItemWidget({
    Key? key,
    required this.subTarefa,
    required this.theme,
    required this.tarefaModel,
    required this.setSubtarefaModel,
    required this.subtarefaActionList,
  }) : super(key: key);

  @override
  State<SubItemWidget> createState() => _SubItemWidgetState();
}

class _SubItemWidgetState extends State<SubItemWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();

    listOptions() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Wrap(
            children: [
              for (var linha in store.client.subtarefaActionList)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InputChip(
                    key: ObjectKey(linha.toString()),
                    labelPadding: const EdgeInsets.all(2),
                    elevation: 4.0,
                    avatar: Icon(ConvertIcon().iconStatus(linha),
                        color: ConvertIcon().iconStatusColor(linha)),
                    label: AutoSizeText(
                      ConvertIcon().labelStatus(linha),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      store.client.setSubtarefaAction(linha);

                      store.changeSubtarefaDioAction(
                        widget.subTarefa,
                        widget.tarefaModel,
                      );
                      setState(() {
                        widget.subTarefa.status = linha;
                      });
                      Modular.to.pop();
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    }

    actionSubtarefa(subTarefaModel, constraint) {
      DialogButtom()
          .showDialog(listOptions(), widget.theme, constraint, context);
    }

    return LayoutBuilder(builder: (context, constraint) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
              color: widget.theme ? Colors.black38 : Colors.black12,
              borderRadius: BorderRadius.circular(4)),
          child: ExpansionTile(
            initiallyExpanded: true,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            key: UniqueKey(),
            title: ListTile(
              leading: SizedBox(
                width: 100,
                child: Text(
                  widget.subTarefa.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.theme ? Colors.grey : Colors.black),
                ),
              ),
              title: GestureDetector(
                onTap: () =>
                    actionSubtarefa(widget.subTarefa, constraint.maxWidth),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    ConvertIcon().iconStatus(widget.subTarefa.status),
                    color:
                        ConvertIcon().iconStatusColor(widget.subTarefa.status),
                  ),
                ),
              ),
              trailing: CircleAvatarWidget(
                url: widget.subTarefa.user.urlImage,
                nameUser: widget.subTarefa.user.name.name,
              ),
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Text(
                    widget.subTarefa.texto,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
