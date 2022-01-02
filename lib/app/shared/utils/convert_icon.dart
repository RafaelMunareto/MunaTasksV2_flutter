import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class ConvertIcon {
  iconStatus(String icon) {
    switch (icon) {
      case 'play':
        return Icons.play_circle;
      case 'pause':
        return Icons.stop_circle_rounded;
      case 'check':
        return Icons.check;
    }
  }
}
