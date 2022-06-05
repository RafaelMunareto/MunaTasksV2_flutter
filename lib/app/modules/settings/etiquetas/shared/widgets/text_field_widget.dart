import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String etiqueta;
  final bool loading;
  final Function setEtiqueta;
  final String? reference;
  final TextEditingController controller;
  const TextFieldWidget({
    Key? key,
    this.etiqueta = "",
    this.loading = false,
    required this.setEtiqueta,
    required this.reference,
    required this.controller,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.etiqueta != '') {
      setState(() {
        widget.controller.text = widget.etiqueta.toString();
      });
    } else {
      setState(() {
        widget.controller.text = '';
      });
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: TextFormField(
          key: widget.reference != null
              ? Key(widget.reference.toString())
              : widget.loading
                  ? Key(widget.etiqueta.toString())
                  : null,
          controller: widget.controller,
          decoration: const InputDecoration(
            label: AutoSizeText(
              'Etiqueta',
              maxLines: 1,
            ),
            icon: Icon(Icons.bookmark),
          ),
        ),
      ),
    );
  }
}
