import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class IconRedondedWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  const IconRedondedWidget(
      {Key? key, required this.icon, required this.color, this.size = 22})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                ? null
                : Border.all(width: 2, color: color)),
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
      );
    });
  }
}
