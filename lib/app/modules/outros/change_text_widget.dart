import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ChangeTextWidget extends StatelessWidget {
  final String title;
  final String corpo;
  const ChangeTextWidget({Key? key, this.title = "", this.corpo = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.start,
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                const Icon(Icons.verified),
                AutoSizeText(
                  ' $title',
                  maxLines: 1,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
            child: AutoSizeText(
              corpo,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ]);
  }
}
