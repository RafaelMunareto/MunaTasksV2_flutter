import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class ScrollSpeed extends StatelessWidget {
  final Widget child;
  static const _extraScrollSpeed = kIsWeb ? 20 : 80;
  final ScrollController _scrollController = ScrollController();

  ScrollSpeed({Key? key, required this.child}) : super(key: key) {
    _scrollController.addListener(() {
      ScrollDirection scrollDirection =
          _scrollController.position.userScrollDirection;
      if (scrollDirection != ScrollDirection.idle) {
        double scrollEnd = _scrollController.offset +
            (scrollDirection == ScrollDirection.reverse
                ? _extraScrollSpeed
                : -_extraScrollSpeed);
        scrollEnd = min(_scrollController.position.maxScrollExtent,
            max(_scrollController.position.minScrollExtent, scrollEnd));
        _scrollController.jumpTo(scrollEnd);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(controller: _scrollController, child: child);
  }
}
