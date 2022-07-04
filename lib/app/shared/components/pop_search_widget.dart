import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class PopSearchWidget extends StatefulWidget {
  final Function? setValueSearch;
  final double constraint;
  final Function? changeFilterSearch;
  const PopSearchWidget(
      {Key? key,
      required this.setValueSearch,
      required this.changeFilterSearch,
      required this.constraint})
      : super(key: key);

  @override
  State<PopSearchWidget> createState() => _PopSearchWidgetState();
}

class _PopSearchWidgetState extends State<PopSearchWidget> {
  HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.constraint >= LarguraLayoutBuilder().telaPc
            ? MediaQuery.of(context).size.width * 0.65
            : MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: store.client.theme
                  ? Colors.black45
                  : lightThemeData(context).shadowColor.withOpacity(0.2),
            ),
            BoxShadow(
              color: store.client.theme
                  ? darkThemeData(context).scaffoldBackgroundColor
                  : lightThemeData(context).dialogBackgroundColor,
              spreadRadius: -2.0,
              blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          onChanged: (value) async {
            await widget.setValueSearch!(value);
            await widget.changeFilterSearch!();
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          autofocus: true,
        ),
      ),
    );
  }
}
