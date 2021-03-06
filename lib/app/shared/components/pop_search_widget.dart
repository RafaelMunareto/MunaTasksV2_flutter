import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

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
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.constraint >= LarguraLayoutBuilder().telaPc
            ? MediaQuery.of(context).size.width * 0.70
            : MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          controller: controller,
          onChanged: (value) async {
            await widget.setValueSearch!(value);
            await widget.changeFilterSearch!();
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: GestureDetector(
              onTap: () {
                widget.setValueSearch!('');
                widget.changeFilterSearch!();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    controller.text = '';
                    widget.setValueSearch!('');
                    widget.changeFilterSearch!();
                  },
                  child: const Icon(Icons.clear),
                ),
              ),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          autofocus: false,
        ),
      ),
    );
  }
}
