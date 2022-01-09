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

  convertColorAndName(String colors) {
    switch (colors) {
      case 'blue':
        return ['Azul', Colors.blue];
      case 'red':
        return ['Vermleho', Colors.red];
      case 'green':
        return ['Verde', Colors.green];
      case 'grey':
        return ['Cinza', Colors.grey];
      case 'dark':
        return ['Preto', Colors.black];
      case 'yellow':
        return ['Amarelo', Colors.yellow];
      case 'orange':
        return ['Laranja', Colors.orange];
    }
  }
}
