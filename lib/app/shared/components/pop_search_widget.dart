import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class PopSearchWidget extends StatefulWidget {
  final Function? setValueSearch;
  final Function? changeFilterSearch;
  const PopSearchWidget(
      {Key? key,
      required this.setValueSearch,
      required this.changeFilterSearch})
      : super(key: key);

  @override
  State<PopSearchWidget> createState() => _PopSearchWidgetState();
}

class _PopSearchWidgetState extends State<PopSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlayAnimation<double>(
        tween: Tween(begin: 0.1, end: MediaQuery.of(context).size.width * 0.7),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
        builder: (context, child, value) {
          return Container(
            width: value,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextFormField(
              onChanged: (value) async {
                await widget.setValueSearch!(value);
                await widget.changeFilterSearch!();
              },
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              autofocus: true,
            ),
          );
        },
      ),
    );
  }
}
