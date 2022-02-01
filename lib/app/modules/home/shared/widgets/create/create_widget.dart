import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/action_fase_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/button_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/date_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/etiquetas_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/prioridade_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/subtarefa/create_subtarefa_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/text_save_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/users_save_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class CreateWidget extends StatefulWidget {
  final AnimationController controller;

  const CreateWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget>
    with SingleTickerProviderStateMixin {
  late Animation altura;
  late Animation<double> opacidade;
  TextEditingController textController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final HomeStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    altura = Tween<double>(begin: 0, end: MediaQuery.of(context).size.height)
        .animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.1, 0.7),
      ),
    );

    opacidade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.1, 0.7),
      ),
    );
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (ctx, ch) {
        if (widget.controller.status == AnimationStatus.dismissed) {
          textController.text = '';
        }
        return opacidade.value == 0
            ? Container()
            : Observer(
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 8),
                    child: FadeTransition(
                      opacity: opacidade,
                      child: GestureDetector(
                        onTap: () =>
                            FocusScope.of(context).requestFocus(FocusNode()),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 4,
                            shape: Border(
                              top: BorderSide(
                                  color: ConvertIcon().convertColor(store
                                          .clientCreate
                                          .tarefaModelSaveEtiqueta
                                          .color) ??
                                      Colors.grey,
                                  width: 5),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: const [
                                      EtiquetasSaveWidget(),
                                      ActionFaseSaveWidget(),
                                      UsersSaveWidget(),
                                    ],
                                  ),
                                ),
                                TextSaveWidget(controller: textController),
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceAround,
                                    children: [
                                      DateSaveWidget(
                                          dateController: dateController),
                                      const PrioridadeSaveWidget(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Wrap(
                                    children: [
                                      const CreateSubtarefaWidget(),
                                      ButtonSaveWidget(
                                        controller: widget.controller,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
