import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class CircularProgressWidget extends StatelessWidget {
  final String title;
  const CircularProgressWidget(
      {Key? key, this.title = "CircularProgressWidget"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: lightThemeData(context).primaryColorLight,
    );
  }
}
