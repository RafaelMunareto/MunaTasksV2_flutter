// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class LayoutCreateSubtarefasWidget extends StatelessWidget {
  final double constraint;
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;
  final Widget widget4;
  const LayoutCreateSubtarefasWidget({
    Key? key,
    required this.constraint,
    required this.widget1,
    required this.widget2,
    required this.widget3,
    required this.widget4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return constraint >= LarguraLayoutBuilder().telaPc
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: widget1,
              ),
              Flexible(
                flex: 3,
                child: widget2,
              ),
              Flexible(
                flex: 3,
                child: widget3,
              ),
              Flexible(
                flex: 2,
                child: widget4,
              )
            ],
          )
        : SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1120,
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: widget1,
                  ),
                  Flexible(
                    flex: 3,
                    child: widget2,
                  ),
                  Flexible(
                    flex: 3,
                    child: widget3,
                  ),
                  Flexible(
                    flex: 2,
                    child: widget4,
                  )
                ],
              ),
            ),
          );
  }
}
