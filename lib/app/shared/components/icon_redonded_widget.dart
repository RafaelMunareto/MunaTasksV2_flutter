import 'package:flutter/material.dart';

class IconRedondedWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  const IconRedondedWidget({Key? key, required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 2, color: color)),
        child: Icon(
          icon,
          color: color,
        ));
  }
}
