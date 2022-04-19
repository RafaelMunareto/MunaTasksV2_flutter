import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  final String title;
  const CircularProgressWidget(
      {Key? key, this.title = "CircularProgressWidget"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
