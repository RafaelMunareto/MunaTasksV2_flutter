import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class TarefasNoneWidget extends StatelessWidget {
  final bool theme;
  const TarefasNoneWidget({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: PhysicalModel(
          color: Colors.transparent,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
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
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'Você ainda não possui tarefas!',
                    style: TextStyle(
                      color: theme
                          ? darkThemeData(context).primaryColor
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
