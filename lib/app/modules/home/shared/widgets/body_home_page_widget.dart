import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_widget.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class BodyHomePageWidget extends StatefulWidget {
  final double constraint;
  const BodyHomePageWidget({
    Key? key,
    required this.constraint,
  }) : super(key: key);

  @override
  State<BodyHomePageWidget> createState() => _BodyHomePageWidgetState();
}

class _BodyHomePageWidgetState extends State<BodyHomePageWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: widget.constraint >= LarguraLayoutBuilder().telaPc ? 7 : 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: const [
                  CardWidget(),
                ],
              ),
            ),
          ),
          // widget.constraint >= LarguraLayoutBuilder().telaPc
          //     ? Expanded(
          //         flex: 3,
          //         child: Center(
          //           child: LandscapeWidget(
          //             theme: store.client.theme,
          //             constraint: widget.constraint,
          //           ),
          //         ),
          //       )
          //     : Container()
        ],
      ),
    );
  }
}
