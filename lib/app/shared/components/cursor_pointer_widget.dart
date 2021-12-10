import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CursorPointerWidget extends StatefulWidget {
  final String route;
  final String label;

  const CursorPointerWidget({Key? key, required this.route, required this.label}) : super(key: key);

  @override
  State<CursorPointerWidget> createState() => _CursorPointerWidgetState();
}

class _CursorPointerWidgetState extends State<CursorPointerWidget> {
  bool _hover = false;


  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        _hover = true;
      }),
      onExit: (event) => setState(() {
        _hover = false;
      }),
      child: GestureDetector(
        child: Text(
          widget.label,
          style: TextStyle(
              color: _hover ? Colors.blue : const Color(0XFF2661FA),
              fontSize: 12.0),
        ),
        onTap: () => Modular.to.navigate(widget.route),
      ),
    );
  }
}