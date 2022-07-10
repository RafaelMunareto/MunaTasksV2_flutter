import 'package:flutter/material.dart';

class MouseRegionWidget extends StatelessWidget {
  final Widget? child;
  final Function? function;
  const MouseRegionWidget({Key? key, this.child, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function!(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: child,
      ),
    );
  }
}
