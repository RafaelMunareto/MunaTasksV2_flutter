import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class DialogButtom {
  showDialog(dynamic widgets, bool theme, context, {double width = 300.00}) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: width,
            width: kIsWeb || Platform.isWindows
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width,
            child: SizedBox.expand(
              child: widgets,
            ),
            margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme
                  ? darkThemeData(context).scaffoldBackgroundColor
                  : lightThemeData(context).scaffoldBackgroundColor,
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  showDialogCreate(dynamic widgets, context) {
    bool _darkModeEnabled = false;

    final ThemeData theme = Theme.of(context);
    theme.brightness == Brightness.dark
        ? _darkModeEnabled = true
        : _darkModeEnabled = false;

    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: kIsWeb || Platform.isWindows
                ? MediaQuery.of(context).size.width * 0.50
                : MediaQuery.of(context).size.width,
            child: SizedBox.expand(
              child: widgets,
            ),
            margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:
                  !_darkModeEnabled ? Colors.transparent : Colors.transparent,
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }
}
