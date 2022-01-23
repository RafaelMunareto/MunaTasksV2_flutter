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

  convertColorAndName(String colors) {
    switch (colors) {
      case 'blue':
        return ['Azul', Colors.blue];
      case 'red':
        return ['Vermelho', Colors.red];
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

  convertColor(String colors) {
    switch (colors) {
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'grey':
        return Colors.grey;
      case 'dark':
        return Colors.black;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
    }
  }

  convertColorFlaf(int color) {
    switch (color) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.amber;
      case 3:
        return Colors.grey;
      default:
        return Colors.black38;
    }
  }
}
