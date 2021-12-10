import 'package:flutter/material.dart';

import 'cursor_pointer_widget.dart';

class LinkRoteWidget extends StatefulWidget {
  final String label;
  final String labelBold;
  final String rota;

  const LinkRoteWidget(
      {Key? key, this.label = '', this.labelBold = '', required this.rota})
      : super(key: key);

  @override
  State<LinkRoteWidget> createState() => _LinkRoteWidgetState();
}

class _LinkRoteWidgetState extends State<LinkRoteWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoFade;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _animacaoFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FadeTransition(
            opacity: _animacaoFade,
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
          FadeTransition(
            opacity: _animacaoFade,
            child: CursorPointerWidget(
                route: widget.rota, label: widget.labelBold),
          )
        ],
      ),
    );
  }
}
