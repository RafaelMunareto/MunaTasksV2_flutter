import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';

class CreateSubtarefaWidget extends StatefulWidget {
  final dynamic subtarefaList;
  final dynamic subtarefaInserSelection;
  final Function setSubtarefaSelection;
  const CreateSubtarefaWidget({
    Key? key,
    required this.subtarefaList,
    required this.subtarefaInserSelection,
    required this.setSubtarefaSelection,
  }) : super(key: key);

  @override
  State<CreateSubtarefaWidget> createState() => _CreateSubtarefaWidgetState();
}

class _CreateSubtarefaWidgetState extends State<CreateSubtarefaWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ExpansionTile(
          title: const Text('SubTarefa'),
          subtitle: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.30,
            child: Observer(
              builder: (_) {
                if (widget.subtarefaList!.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<SubtarefaInsertModel> list = widget.subtarefaList!.data;
                  return Wrap(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            var model = list[index];
                            return Center(
                              child: ListTile(
                                key: Key(model.subtarefa.toString()),
                                title: Text(
                                  model.subtarefa,
                                ),
                                leading: Radio(
                                  value: model.subtarefa,
                                  groupValue: widget.subtarefaInserSelection,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.setSubtarefaSelection(value);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
