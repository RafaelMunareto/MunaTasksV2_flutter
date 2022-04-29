import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class TarefasPage extends StatefulWidget {
  final String title;
  final bool theme;
  const TarefasPage({
    Key? key,
    this.title = 'Tarefas',
    this.theme = false,
  }) : super(key: key);
  @override
  TarefasPageState createState() => TarefasPageState();
}

class TarefasPageState extends State<TarefasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
            title: widget.title,
            context: context,
            icon: Icons.task,
            settings: true,
            rota: '/home/',
            back: true),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: widget.theme
                            ? Colors.black54
                            : lightThemeData(context)
                                .shadowColor
                                .withOpacity(0.2),
                      ),
                      BoxShadow(
                        color: widget.theme
                            ? darkThemeData(context).scaffoldBackgroundColor
                            : lightThemeData(context).scaffoldBackgroundColor,
                        spreadRadius: -3.0,
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: const LandscapeWidget(),
                ),
              ),
            ),
          ),
        ));
  }
}
