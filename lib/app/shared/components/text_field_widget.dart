import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TextFieldWidget extends StatefulWidget {
  final String labelText;
  final dynamic onChanged;
  final bool obscure;
  final dynamic errorText;
  final dynamic function;
  final bool functionBool;
  final bool outline;
  final dynamic initialValue;

  const TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.onChanged,
    this.obscure = false,
    required this.errorText,
    this.outline = false,
    this.initialValue = '',
    this.function,
    this.functionBool = false,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoSize;
  TextEditingController initial = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      initial.text = widget.initialValue;
    });

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextField(
            key: Key(widget.labelText),
            onChanged: widget.onChanged,
            onEditingComplete: () {
              if (widget.functionBool) {
                widget.function();
              }
            },
            controller: initial,
            obscureText: widget.obscure,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: Colors.redAccent),
              border: !widget.outline ? null : const OutlineInputBorder(),
              labelText: widget.labelText,
              errorText: widget.errorText == null ? null : widget.errorText(),
            ),
          ),
        ),
      );
    });
  }
}
