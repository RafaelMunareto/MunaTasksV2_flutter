import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card_int_widget.dart';
import 'package:munatasks2/app/shared/components/tarefas_none_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  final HomeStore store = Modular.get();
  var list = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        if (store.client.taskDioSearch.isNotEmpty) {
          setState(() {
            list = store.client.taskDioSearch;
          });
        } else {
          setState(() {
            list = store.client.taskDio;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: store.client.theme
                    ? Colors.black54
                    : lightThemeData(context).shadowColor.withOpacity(0.2),
              ),
              BoxShadow(
                color: store.client.theme
                    ? darkThemeData(context).scaffoldBackgroundColor
                    : lightThemeData(context).scaffoldBackgroundColor,
                spreadRadius: -3.0,
                blurRadius: 4.0,
              ),
            ],
          ),
          child: LayoutBuilder(builder: (context, constraint) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(
                builder: (_) {
                  return store.client.loadingTasks
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: const Center(
                            child: CircularProgressWidget(),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              key: UniqueKey(),
                              flex: 1,
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: list.isEmpty
                                    ? TarefasNoneWidget(
                                        theme: store.client.theme)
                                    : ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        controller: ScrollController(),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(4),
                                        itemCount: list.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CardIntWidget(
                                            tarefaDioModel: list[index],
                                            constraint: constraint.maxWidth,
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
