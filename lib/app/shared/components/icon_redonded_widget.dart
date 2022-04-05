import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IconRedondedWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  const IconRedondedWidget(
      {Key? key, required this.icon, required this.color, this.size = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: kIsWeb && defaultTargetPlatform == TargetPlatform.windows
                ? null
                : Border.all(width: 2, color: color)),
        child: Icon(
          icon,
          color: color,
          size: size,
        ));
  }
}
