import 'dart:io';

import 'package:flutter/material.dart';

class DialogButtom {
  showDialog(dynamic widgets, context, {double width = 300.00}) {
    bool _darkModeEnabled = false;

    final ThemeData theme = Theme.of(context);
    theme.brightness == Brightness.dark
        ? _darkModeEnabled = true
        : _darkModeEnabled = false;

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
            width: Platform.isWindows
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width,
            child: SizedBox.expand(
              child: widgets,
            ),
            margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: !_darkModeEnabled ? Colors.white : Colors.black,
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
            width: Platform.isWindows
                ? MediaQuery.of(context).size.width * 0.65
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
