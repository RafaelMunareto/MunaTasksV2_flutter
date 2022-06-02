import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListMenuWidget extends StatelessWidget {
  final String label;
  final String rota;
  final IconData icon;
  const ListMenuWidget(
      {Key? key, required this.label, required this.rota, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon),
          ),
          Flexible(
            child: SizedBox(
              child: AutoSizeText(
                label,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Modular.to.navigate(rota);
      },
    );
  }
}
