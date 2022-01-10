// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class ValidateWidget extends StatelessWidget {
  final Function validateEtiqueta;
  final Function validateColor;
  final Function validateIcon;
  const ValidateWidget(
      {Key? key,
      required this.validateEtiqueta,
      required this.validateColor,
      required this.validateIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          validateEtiqueta() != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(24, 2, 16, 2),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Text(
                        'Etiqueta - ' + validateEtiqueta().toString(),
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      )),
                )
              : Container(),
          validateColor() != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(24, 2, 16, 2),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Text(
                        'Cor - ' + validateColor().toString(),
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      )),
                )
              : Container(),
          validateIcon() != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(24, 2, 16, 2),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Text(
                        'Icone - ' + validateIcon().toString(),
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      )),
                )
              : Container(),
        ],
      ),
    );
  }
}
