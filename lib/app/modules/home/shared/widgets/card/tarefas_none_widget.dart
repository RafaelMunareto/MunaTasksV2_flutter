import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class TarefasNoneWidget extends StatelessWidget {
  final String title;
  final bool theme;
  const TarefasNoneWidget(
      {Key? key,
      required this.theme,
      this.title = 'Você não possui tarefas nesta categoria!'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: PhysicalModel(
          color: Colors.transparent,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: theme
                            ? darkThemeData(context).primaryColor
                            : lightThemeData(context).primaryColor,
                        width: 15),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme
                          ? Colors.white
                          : lightThemeData(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
