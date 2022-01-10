// ignore_for_file: unnecessary_null_comparison
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/widgets/colors_widget.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/widgets/etiquetas_widget.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/widgets/icon_widget.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/widgets/text_field_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/button_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';

class EtiquetasPage extends StatefulWidget {
  final String title;
  const EtiquetasPage({Key? key, this.title = 'Etiquetas'}) : super(key: key);
  @override
  EtiquetasPageState createState() => EtiquetasPageState();
}

class EtiquetasPageState extends State<EtiquetasPage>
    with SingleTickerProviderStateMixin {
  final EtiquetasStore store = Modular.get();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        if (store.etiquetaStore.msg != '') {
          SnackbarCustom()
              .createSnackBar(store.etiquetaStore.msg, Colors.green, context);
          store.etiquetaStore.setMsg('');
          if (store.etiquetaStore.errOrGoal) {
            SnackbarCustom()
                .createSnackBar(store.etiquetaStore.msg, Colors.red, context);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(
          title: widget.title,
          icon: Icons.bookmark,
          context: context,
          settings: true,
          rota: '/home'),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            store.etiquetaStore.setColorAction(false);
          },
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Observer(builder: (_) {
                return TextFieldWidget(
                  etiqueta: store.etiquetaStore.etiqueta,
                  loading: store.etiquetaStore.loading,
                  reference: store.etiquetaStore.reference,
                  setEtiqueta: store.etiquetaStore.setEtiqueta,
                );
              }),
              Observer(builder: (_) {
                return IconWidget(
                    setIcon: store.etiquetaStore.setIcon,
                    icon: store.etiquetaStore.icon,
                    color: store.etiquetaStore.color);
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                    child: Observer(builder: (_) {
                      return GestureDetector(
                        child: ListTile(
                          leading: Icon(
                            Icons.color_lens,
                            color: ConvertIcon()
                                .convertColor(store.etiquetaStore.color),
                          ),
                          title: Text(
                            'Escolha uma cor',
                            style: TextStyle(
                              color: ConvertIcon()
                                  .convertColor(store.etiquetaStore.color),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(
                            () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              store.etiquetaStore.setColorAction(
                                  !store.etiquetaStore.colorAction);
                              setState(() {
                                store.etiquetaStore.colorAction
                                    ? controller.forward()
                                    : controller.reverse();
                              });
                            },
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
              Observer(
                builder: (_) {
                  return ColorsWidget(
                    colorAction: store.etiquetaStore.colorAction,
                    colorsList: store.etiquetaStore.colorsList,
                    getColors: store.getColors,
                    color: store.etiquetaStore.color,
                    setColor: store.etiquetaStore.setColor,
                    controller: controller,
                  );
                },
              ),
              Observer(builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                      label: store.etiquetaStore.updateLoading
                          ? 'ATUALIZAR'
                          : 'SALVAR',
                      width: MediaQuery.of(context).size.width * 0.5,
                      loading: store.etiquetaStore.loading,
                      function: store.submit),
                );
              }),
              EtiquetasWidget(
                etiquetasList: store.etiquetaStore.etiquetaList,
                getList: store.getList,
                delete: store.delete,
                loadingUpdate: store.loadingUpdate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
