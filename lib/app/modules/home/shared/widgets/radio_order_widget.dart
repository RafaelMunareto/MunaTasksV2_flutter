import 'package:flutter/material.dart';

class RadioOrderWidget extends StatelessWidget {
  final String title;
  const RadioOrderWidget({Key? key, this.title = "RadioOrderWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(title));
  }
}