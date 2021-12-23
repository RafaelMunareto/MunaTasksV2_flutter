import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';

class NamesWidget extends StatefulWidget {
  final bool textFieldNameBool;
  final PerfilModel perfil;
  final Function changeName;
  final Function save;
  final Function showTextFieldName;
  final Function changeTime;
  final Function changeManager;
  const NamesWidget(
      {Key? key,
      required this.textFieldNameBool,
      required this.perfil,
      required this.changeName,
      required this.save,
      required this.showTextFieldName,
      required this.changeTime,
      required this.changeManager})
      : super(key: key);

  @override
  State<NamesWidget> createState() => _NamesWidgetState();
}

class _NamesWidgetState extends State<NamesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Observer(builder: (_) {
        //       return widget.textFieldNameBool
        //           ? SizedBox(
        //               width: 200,
        //               child: Chip(
        //                 label: Text(widget.perfil.name),
        //               ),
        //             )
        //           : SizedBox(
        //               width: 200,
        //               child: TextFormField(
        //                 initialValue: widget.perfil.name,
        //                 onChanged: (value) {
        //                   widget.changeName(value);
        //                 },
        //                 decoration: const InputDecoration(
        //                   label: Text('Nome'),
        //                 ),
        //               ),
        //             );
        //     }),
        //     MouseRegion(
        //       cursor: SystemMouseCursors.click,
        //       child: GestureDetector(
        //         onTap: () {
        //           setState(() {
        //             widget.showTextFieldName(!widget.textFieldNameBool);
        //             widget.save();
        //           });
        //         },
        //         child: Icon(
        //           widget.textFieldNameBool ? Icons.edit : Icons.save,
        //           color: ThemeData.light().primaryColor,
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        Row(
          children: [
            SizedBox(
              width: 300,
              height: 100,
              child: ListTile(
                leading: SizedBox(
                  width: 250,
                  child: TextFormField(
                    initialValue: widget.perfil.nameTime,
                    onChanged: (value) {
                      widget.changeTime(value);
                    },
                    decoration: const InputDecoration(
                      label: Text('Time'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              child: GestureDetector(
                child: SizedBox(
                  width: 50,
                  child: Icon(
                    Icons.save,
                    color: ThemeData().primaryColor,
                  ),
                ),
                onTap: () {
                  widget.save();
                },
              ),
            )
          ],
        ),
        ListTile(
          leading: const Text('Técnico'),
          title: Switch(
              value: widget.perfil.manager,
              onChanged: (value) {
                setState(() {
                  widget.changeManager(value);
                  widget.save();
                });
              }),
          trailing: const Text('Gerente'),
        ),
      ],
    );
  }
}
