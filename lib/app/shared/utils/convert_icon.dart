import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
