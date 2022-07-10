import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class PrivacyTextWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final String corpo;
  final String corpo1;
  final double constraint;
  final bool theme;
  const PrivacyTextWidget(
      {Key? key,
      this.title = "",
      this.subtitle = "",
      this.corpo = '',
      this.corpo1 = '',
      required this.theme,
      required this.constraint})
      : super(key: key);

  @override
  State<PrivacyTextWidget> createState() => _PrivacyTextWidgetState();
}

class _PrivacyTextWidgetState extends State<PrivacyTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Container(
        width: widget.constraint >= LarguraLayoutBuilder().telaPc
            ? MediaQuery.of(context).size.width * 0.55
            : MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: widget.theme
                  ? Colors.black45
                  : lightThemeData(context).shadowColor.withOpacity(0.2),
            ),
            BoxShadow(
              color: widget.theme
                  ? darkThemeData(context).scaffoldBackgroundColor
                  : lightThemeData(context).dialogBackgroundColor,
              spreadRadius: -2.0,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Wrap(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      top: 8.0,
                      left: 10,
                    ),
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.up,
                        children: [
                          Text(
                            ' ${widget.title}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 1.0,
                      top: 0.0,
                      left: 10,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Text(
                          ' ${widget.subtitle}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Wrap(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(64, 20, 64, 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    widget.corpo,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
