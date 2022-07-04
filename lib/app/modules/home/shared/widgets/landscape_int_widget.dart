import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class LandscapeIntWidget extends StatefulWidget {
  final double constraint;
  final bool theme;
  const LandscapeIntWidget({
    Key? key,
    required this.constraint,
    required this.theme,
  }) : super(key: key);

  @override
  State<LandscapeIntWidget> createState() => _LandscapeIntWidgetState();
}

class _LandscapeIntWidgetState extends State<LandscapeIntWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get();

    return Observer(builder: (_) {
      return store.client.loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (var totais in store.client.tarefasTotais)
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: CircleAvatarWidget(
                                  nameUser: totais.name.name.name,
                                  url: totais.name!.urlImage,
                                ),
                              ),
                              totais.qtd > 0
                                  ? AutoSizeText(
                                      totais.qtd > 1
                                          ? totais.qtd.toString()
                                          : totais.qtd.toString(),
                                      maxLines: 1,
                                    )
                                  : const AutoSizeText('0',
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
