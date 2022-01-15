import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/order_model.dart';

class RadioOrderWidget extends StatefulWidget {
  final dynamic orderList;
  final dynamic orderSelection;
  final Function changeOrderList;
  final Function setOrderSelection;
  final bool orderAscDesc;
  final Function setOrderAscDesc;
  const RadioOrderWidget(
      {Key? key,
      required this.orderList,
      required this.orderSelection,
      required this.changeOrderList,
      this.orderAscDesc = false,
      required this.setOrderAscDesc,
      required this.setOrderSelection})
      : super(key: key);

  @override
  State<RadioOrderWidget> createState() => _RadioOrderWidgetState();
}

class _RadioOrderWidgetState extends State<RadioOrderWidget> {
  String switchOrder = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.30,
      child: Observer(
        builder: (_) {
          if (widget.orderList!.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<OrderModel> list = widget.orderList!.data;
            return Wrap(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ListTile(
                    leading: const Text(
                      'ASC',
                    ),
                    title: Switch(
                        value: widget.orderAscDesc,
                        onChanged: (_) {
                          setState(() {
                            widget.setOrderAscDesc(!widget.orderAscDesc);
                            widget.changeOrderList();
                          });
                        }),
                    trailing: const Text('DESC'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      var model = list[index];
                      return Center(
                        child: ListTile(
                          key: Key(model.grupo.toString()),
                          title: Text(
                            model.grupo,
                          ),
                          leading: Radio(
                            value: model.grupo,
                            groupValue: widget.orderSelection,
                            onChanged: (value) {
                              setState(() {
                                widget.setOrderSelection(value);
                                widget.changeOrderList();
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
    );
  }
}
