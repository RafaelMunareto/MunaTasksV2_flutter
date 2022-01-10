import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class ColorsWidget extends StatefulWidget {
  final bool colorAction;
  final dynamic colorsList;
  final Function getColors;
  final String color;
  final Function setColor;
  final dynamic controller;
  const ColorsWidget(
      {Key? key,
      required this.colorAction,
      required this.colorsList,
      required this.getColors,
      required this.color,
      required this.setColor,
      required this.controller})
      : super(key: key);

  @override
  State<ColorsWidget> createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> altura;

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    altura =
        Tween<double>(begin: 0, end: MediaQuery.of(context).size.height * 0.4)
            .animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.6, 0.9),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: _buildAnimation,
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return widget.colorAction
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: altura.value,
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
                              activeColor: ConvertIcon()
                                  .convertColorAndName(model.color)[1],
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
          )
        : Container();
  }
}
