import 'package:flutter/material.dart';

class CircularPMinWidget extends StatelessWidget {
  const CircularPMinWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 22, height: 22, child: CircularProgressIndicator());
  }
}
