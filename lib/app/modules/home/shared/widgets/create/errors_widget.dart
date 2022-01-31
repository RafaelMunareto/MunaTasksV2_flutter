import 'package:flutter/material.dart';

class ErrorsWidget extends StatelessWidget {
  final dynamic erroTexto;
  final dynamic erroTitle;
  final dynamic erroUser;
  const ErrorsWidget({
    Key? key,
    required this.erroTexto,
    required this.erroTitle,
    required this.erroUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List errors = [erroTexto, erroTitle, erroUser];
    return Wrap(
      children: [
        for (var erro in errors)
          erro != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: SizedBox(
                    child: Text(
                      erro.toString(),
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                )
              : Container(),
      ],
    );
  }
}
