import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TextFieldWidget extends StatefulWidget {
  final String labelText;
  final dynamic onChanged;
  final bool obscure;
  final dynamic errorText;

  const TextFieldWidget(
      {Key? key,
      required this.labelText,
      required this.onChanged,
      this.obscure = false,
      required this.errorText})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoSize;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _animacaoSize = Tween<double>(begin: 0, end: 500).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animacaoSize, builder: _buildAnimation);
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Observer(builder: (_) {
      return Container(
        width: _animacaoSize.value,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        // decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(20),
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.grey.shade200, blurRadius: 15, spreadRadius: 4)
        //     ]),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextField(
            onChanged: widget.onChanged,
            obscureText: widget.obscure,
            decoration: InputDecoration(
              //border: const OutlineInputBorder(),
              labelText: widget.labelText,
              errorText: widget.errorText == null ? null : widget.errorText(),
            ),
          ),
        ),
      );
    });
  }
}
