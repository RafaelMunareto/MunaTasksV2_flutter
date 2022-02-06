import 'package:flutter/material.dart';

class DialogButtom {
  showDialog(dynamic widgets, context, {double width = 300.00}) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 600),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: width,
            child: SizedBox.expand(
              child: widgets,
            ),
            margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
