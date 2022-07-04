import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

class ChangeTextWidget extends StatelessWidget {
  final String title;
  final String corpo;
  const ChangeTextWidget({Key? key, this.title = "", this.corpo = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Container(
            //color: Color.fromARGB(255, 125, 194, 250),
            width: MediaQuery.of(context).size.width * 0.55,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 172, 200, 243),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 153, 153, 153),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, top: 8.0, left: 10, right: 20),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: [
                    const Icon(Icons.verified),
                    AutoSizeText(
                      ' $title',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 36, 73)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                child: AutoSizeText(
                  corpo,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 12, 22, 34)),
                ),
              ),
            ])));
  }
}
