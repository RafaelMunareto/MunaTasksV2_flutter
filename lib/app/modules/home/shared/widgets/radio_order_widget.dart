// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';

class RadioOrderWidget extends StatefulWidget {
  const RadioOrderWidget({
    Key? key,
  }) : super(key: key);

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
              child: CircularProgressWidget(),
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
                          value: store.client.orderAscDesc,
                          onChanged: (_) {
                            store.client
                                .setOrderAscDesc(!store.client.orderAscDesc);
                            store.changeOrderList();
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
                              groupValue: store.client.orderSelection,
                              onChanged: (value) {
                                setState(() {
                                  store.client.setOrderSelection(value);
                                  store.changeOrderList();
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
