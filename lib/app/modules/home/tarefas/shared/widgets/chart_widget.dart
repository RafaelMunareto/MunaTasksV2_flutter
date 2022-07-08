import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:munatasks2/app/modules/home/tarefas/tarefas_store.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class ChartWidget extends StatefulWidget {
  final double constraint;
  const ChartWidget({Key? key, required this.constraint}) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  TarefasStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Chart(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.only(left: 20, right: 10),
        layers: [
          ChartGridLayer(
            settings: ChartGridSettings(
              x: ChartGridSettingsAxis(
                color: store.client.theme
                    ? Colors.white.withOpacity(0.01)
                    : Colors.black.withOpacity(0.01),
                frequency: 1.0,
                max: 14.0,
                min: 7.0,
              ),
              y: ChartGridSettingsAxis(
                color: store.client.theme
                    ? Colors.white.withOpacity(0.15)
                    : Colors.black.withOpacity(0.2),
                frequency: 50.0,
                max: 300.0,
                min: 0.0,
              ),
            ),
          ),
          ChartAxisLayer(
            settings: ChartAxisSettings(
              x: ChartAxisSettingsAxis(
                frequency: 1.0,
                max: 13.0,
                min: 7.0,
                textStyle: TextStyle(
                  color: store.client.theme
                      ? Colors.white.withOpacity(0.6)
                      : Colors.black.withOpacity(0.6),
                  fontSize: 10.0,
                ),
              ),
              y: ChartAxisSettingsAxis(
                frequency: 100.0,
                max: 330.0,
                min: 0.0,
                textStyle: TextStyle(
                  color: store.client.theme
                      ? Colors.white.withOpacity(0.6)
                      : Colors.black.withOpacity(0.6),
                  fontSize: 10.0,
                ),
              ),
            ),
            labelX: (value) => 'Nome',
            labelY: (value) => value.toInt().toString(),
          ),
          ChartGroupBarLayer(
            items: List.generate(
              13 - 7 + 1,
              (index) => [
                ChartGroupBarDataItem(
                  color: const Color.fromARGB(255, 76, 175, 80),
                  x: index + 7,
                  value: Random().nextInt(280) + 20,
                ),
                ChartGroupBarDataItem(
                  color: const Color.fromARGB(255, 255, 193, 7),
                  x: index + 7,
                  value: Random().nextInt(280) + 20,
                ),
                ChartGroupBarDataItem(
                  color: const Color.fromARGB(255, 33, 150, 243),
                  x: index + 7,
                  value: Random().nextInt(280) + 20,
                ),
              ],
            ),
            settings: ChartGroupBarSettings(
              thickness: widget.constraint >= LarguraLayoutBuilder().telaPc
                  ? 15.0
                  : 10,
              radius: const BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0)),
            ),
          ),
          ChartTooltipLayer(
            shape: () => ChartTooltipBarShape<ChartGroupBarDataItem>(
              backgroundColor: store.client.theme
                  ? Colors.white.withOpacity(0.78)
                  : Colors.black.withOpacity(0.78),
              currentPos: (item) => item.currentValuePos,
              currentSize: (item) => item.currentValueSize,
              onTextValue: (item) => '${item.value}',
              marginBottom: 6.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              radius: 6.0,
              textStyle: TextStyle(
                color: store.client.theme
                    ? const Color.fromARGB(255, 19, 11, 36)
                    : Colors.white,
                letterSpacing: 0.2,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ]);
  }
}
