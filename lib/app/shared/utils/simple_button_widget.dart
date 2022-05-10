import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class SimpleButtonWidget extends StatelessWidget {
  final bool theme;
  final bool popUp;
  final dynamic dataFunction;
  final Function? function;
  final bool scnack;
  final String msgSnack;
  final String buttonName;
  final bool delete;
  final double? constraint;
  final dynamic getFase;
  const SimpleButtonWidget(
      {Key? key,
      required this.theme,
      this.popUp = false,
      this.function,
      this.dataFunction,
      this.scnack = false,
      required this.buttonName,
      this.msgSnack = '',
      this.delete = false,
      this.constraint,
      this.getFase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          theme
              ? darkThemeData(context).primaryColor
              : lightThemeData(context).primaryColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
              color: theme
                  ? darkThemeData(context).primaryColorLight
                  : lightThemeData(context).primaryColorLight,
              width: 2.0,
            ),
          ),
        ),
      ),
      onPressed: () {
        if (popUp) {
          if (getFase != null) {
            getFase!();
          }
          Modular.to.pop();
        }
        if (function != null) {
          function!(dataFunction);
          if (scnack) {
            SnackbarCustom().createSnackBar(msgSnack, Colors.green, context);
          }
        }
      },
      child: Text(
        buttonName,
        style: TextStyle(
          color: theme
              ? darkThemeData(context).scaffoldBackgroundColor
              : lightThemeData(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
