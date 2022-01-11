import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class ColorsWidget extends StatefulWidget {
  final dynamic colorsList;
  final Function getColors;
  final String color;
  final Function setColor;
  const ColorsWidget({
    Key? key,
    required this.colorsList,
    required this.getColors,
    required this.color,
    required this.setColor,
  }) : super(key: key);

  @override
  State<ColorsWidget> createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Observer(
        builder: (_) {
          if (widget.colorsList.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (widget.colorsList.hasError) {
            return Center(
              child: ElevatedButton(
                onPressed: widget.getColors(),
                child: const Text('Error'),
              ),
            );
          } else {
            List<ColorsModel> list = widget.colorsList.data;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                var model = list[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        ConvertIcon()
                            .convertColorAndName(model.color)[0]
                            .toString(),
                        style: TextStyle(
                            color: ConvertIcon()
                                .convertColorAndName(model.color)[1]),
                      ),
                      leading: Radio(
                        value: model.color.toString(),
                        groupValue: widget.color,
                        activeColor:
                            ConvertIcon().convertColorAndName(model.color)[1],
                        onChanged: (value) {
                          setState(() {
                            widget.setColor(value);
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
