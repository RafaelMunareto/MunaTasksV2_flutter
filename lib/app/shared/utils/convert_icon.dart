import 'package:flutter/material.dart';

class ConvertIcon {
  iconStatus(String icon) {
    switch (icon) {
      case 'play':
        return Icons.play_circle;
      case 'pause':
        return Icons.pause_circle;
      case 'check':
        return Icons.check_circle;
    }
  }

  iconFase(String status) {
    switch (status) {
      case 'pause':
        return 0;
      case 'play':
        return 1;
      case 'check':
        return 2;
    }
  }

  colorStatus(String status) {
    switch (status) {
      case 'play':
        return Colors.green[100];
      case 'pause':
        return Colors.amber[100];
      case 'check':
        return Colors.blue[100];
    }
  }

  colorStatusDark(String status) {
    switch (status) {
      case 'play':
        return Colors.green;
      case 'pause':
        return Colors.amber;
      case 'check':
        return Colors.blue;
    }
  }

  nameStatus(String status) {
    switch (status) {
      case 'play':
        return 'Fazendo';
      case 'pause':
        return 'Backlog';
      case 'check':
        return 'Feito';
    }
  }

  iconStatusColor(String icon) {
    switch (icon) {
      case 'play':
        return Colors.green;
      case 'pause':
        return Colors.amber;
      case 'check':
        return Colors.blue;
    }
  }

  labelStatus(String status) {
    switch (status) {
      case 'play':
        return 'Fazendo';
      case 'pause':
        return 'Backlog';
      case 'check':
        return 'Feito';
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

  convertColorName(String colors) {
    switch (colors) {
      case 'blue':
        return 'Azul';
      case 'red':
        return 'Vermelho';
      case 'green':
        return 'Verde';
      case 'grey':
        return 'Cinza';
      case 'dark':
        return 'Preto';
      case 'yellow':
        return 'Amarelo';
      case 'orange':
        return 'Laranja';
      case 'amber':
        return 'Âmbar';
      case 'brown':
        return 'Marrom';
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
      case 'amber':
        return Colors.amber;
      case 'orange':
        return Colors.orange;
      case 'brown':
        return Colors.brown;
    }
  }

  convertColorFase(String colors) {
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
      case 'amber':
        return Colors.amber;
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
        return Colors.grey;
    }
  }
}
