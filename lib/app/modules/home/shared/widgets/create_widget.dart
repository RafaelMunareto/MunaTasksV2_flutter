import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class CreateWidget extends StatefulWidget {
  final TarefaModel tarefaModel;
  final AnimationController controller;
  final Function saveSetEtiqueta;
  final dynamic etiquetaList;
  final EtiquetaModel etiquetaModel;
  const CreateWidget({
    Key? key,
    required this.controller,
    required this.tarefaModel,
    required this.saveSetEtiqueta,
    required this.etiquetaList,
    required this.etiquetaModel,
  }) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget>
    with SingleTickerProviderStateMixin {
  late Animation altura;
  late Animation<double> opacidade;

  @override
  Widget build(BuildContext context) {
    etiquetas() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Etiquetas'),
            content: RadioEtiquetasFilterWidget(
              etiquetaList: widget.etiquetaList,
              create: true,
              setEtiquetaSave: widget.saveSetEtiqueta,
            ),
          );
        },
      );
    }

    users() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Etiquetas'),
            content: Observer(
              builder: (_) {
                return RadioEtiquetasFilterWidget(
                  etiquetaList: widget.etiquetaList,
                  create: true,
                  setEtiquetaSelection: widget.saveSetEtiqueta,
                );
              },
            ),
          );
        },
      );
    }

    altura =
        Tween<double>(begin: 0, end: MediaQuery.of(context).size.height * 0.3)
            .animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.1, 0.7),
      ),
    );

    opacidade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: widget.controller, curve: const Interval(0.6, 0.8)));

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (ctx, ch) {
        return SizedBox(
          child: FadeTransition(
            opacity: opacidade,
            child: Card(
              shape: Border(
                top: BorderSide(
                    color: ConvertIcon()
                            .convertColor(widget.etiquetaModel.color) ??
                        Colors.grey,
                    width: 5),
              ),
              elevation: 8,
              child: Wrap(
                children: [
                  GestureDetector(
                    child: ListTile(
                      leading: Chip(
                        label: Text(widget.etiquetaModel.icon != null
                            ? widget.etiquetaModel.etiqueta
                            : 'Escolha uma etiqueta'),
                        avatar: Icon(
                          widget.etiquetaModel.icon != null
                              ? IconData(widget.etiquetaModel.icon ?? 0,
                                  fontFamily: 'MaterialIcons')
                              : Icons.bookmark,
                          color: ConvertIcon()
                              .convertColor(widget.etiquetaModel.color),
                        ),
                      ),
                    ),
                    onTap: () => etiquetas(),
                  ),
                ],
              ),
            ),
          ),
          height: altura.value,
        );
      },
    );
  }
}
