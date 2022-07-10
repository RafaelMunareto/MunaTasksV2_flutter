import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class LayoutCreateWidget extends StatelessWidget {
  final double constraint;
  final Widget widget1;
  final Widget widget2;
  const LayoutCreateWidget({
    Key? key,
    required this.constraint,
    required this.widget1,
    required this.widget2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return constraint >= LarguraLayoutBuilder().telaPc
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: widget1,
              ),
              Flexible(
                flex: 7,
                child: widget2,
              )
            ],
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  widget1,
                  widget2,
                ],
              ),
            ),
          );
  }
}
