import 'package:flutter/foundation.dart';
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
  const CreateWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget> {
  TextEditingController textController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 2, 8),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: ConvertIcon().convertColor(
                        store.clientCreate.tarefaModelSaveEtiqueta.color,
                      ),
                      width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 16,
                child: Wrap(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: kIsWeb &&
                                defaultTargetPlatform == TargetPlatform.windows
                            ? const EdgeInsets.all(8)
                            : const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8,
                                right: 4,
                                left: 4,
                              ),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: const [
                            EtiquetasSaveWidget(),
                            ActionFaseSaveWidget(),
                            UsersSaveWidget(),
                          ],
                        ),
                      ),
                    ),
                    TextSaveWidget(controller: textController),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          children: [
                            DateSaveWidget(dateController: dateController),
                            const PrioridadeSaveWidget(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Wrap(
                        children: const [
                          CreateSubtarefaWidget(),
                          ButtonSaveWidget()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
