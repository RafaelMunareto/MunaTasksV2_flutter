// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';

class RadioOrderWidget extends StatefulWidget {
  final dynamic orderSelection;
  final Function changeOrderList;
  final Function setOrderSelection;
  final bool orderAscDesc;
  final Function setOrderAscDesc;
  const RadioOrderWidget(
      {Key? key,
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
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Observer(
        builder: (_) {
          if (store.client.settings == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<dynamic>? list = store.client.settings.order;
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: const Text(
                      'ASC',
                    ),
                    title: Transform.scale(
                      scale: 1.5,
                      child: Switch(
                          value: widget.orderAscDesc,
                          onChanged: (_) {
                            widget.setOrderAscDesc(!widget.orderAscDesc);
                            widget.changeOrderList();
                          }),
                    ),
                    trailing: const Text('DESC'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var linha in list ?? [])
                          ListTile(
                            key: Key(linha.toString()),
                            title: Text(
                              linha,
                            ),
                            leading: Radio(
                              value: linha.toString(),
                              groupValue: widget.orderSelection,
                              onChanged: (value) {
                                setState(() {
                                  widget.setOrderSelection(value);
                                  widget.changeOrderList();
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Baseline(
                  baseline: MediaQuery.of(context).size.height * 0.08,
                  baselineType: TextBaseline.ideographic,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      child: const Text('FECHAR'),
                    ),
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
