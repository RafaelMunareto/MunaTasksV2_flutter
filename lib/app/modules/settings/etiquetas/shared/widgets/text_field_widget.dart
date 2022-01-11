import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String etiqueta;
  final bool loading;
  final Function setEtiqueta;
  final DocumentReference? reference;
  const TextFieldWidget(
      {Key? key,
      this.etiqueta = "",
      this.loading = false,
      required this.setEtiqueta,
      required this.reference})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
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
          initialValue: widget.etiqueta,
          onChanged: (value) {
            widget.setEtiqueta(value);
          },
          decoration: const InputDecoration(
            label: Text('Etiqueta'),
            icon: Icon(Icons.bookmark),
          ),
        ),
      ),
    );
  }
}
