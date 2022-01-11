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
import 'package:munatasks2/app/modules/settings/etiquetas/shared/widgets/validate_widget.dart';
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

  late AnimationController _controller;
  late Animation<double> opacidade;
  late Animation<double> radius;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        store.etiquetaStore.updateLoading
            ? _controller.forward()
            : _controller.reverse();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    opacidade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.8)));
    radius = Tween<double>(begin: 0, end: 40).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1)));

    return AnimatedBuilder(
      animation: _controller,
      builder: _buildAnimation,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
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
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Wrap(
            direction: Axis.vertical,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Observer(builder: (_) {
                  return store.etiquetaStore.updateLoading
                      ? FadeTransition(
                          opacity: opacidade,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(radius.value),
                                      side: const BorderSide(
                                        color: Colors.deepPurple,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  store.etiquetaStore.setCleanVariables();
                                  store.etiquetaStore.setUpdateLoading(false);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.deepPurple,
                                ),
                                label: const Text(
                                  'Novo',
                                  style: TextStyle(color: Colors.deepPurple),
                                )),
                          ),
                        )
                      : Container();
                }),
              ),
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
                  color: store.etiquetaStore.color,
                );
              }),
              Observer(builder: (_) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ExpansionTile(
                    onExpansionChanged: (value) =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    leading: Icon(
                      Icons.color_lens,
                      color:
                          ConvertIcon().convertColor(store.etiquetaStore.color),
                    ),
                    title: Text(
                      'Escolha uma cor',
                      style: TextStyle(
                        color: ConvertIcon()
                            .convertColor(store.etiquetaStore.color),
                      ),
                    ),
                    children: <Widget>[
                      Observer(
                        builder: (_) {
                          return ColorsWidget(
                            colorsList: store.etiquetaStore.colorsList,
                            getColors: store.getColors,
                            color: store.etiquetaStore.color,
                            setColor: store.etiquetaStore.setColor,
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
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
              Observer(
                builder: (_) {
                  return store.etiquetaStore.showValidation
                      ? ValidateWidget(
                          validateEtiqueta:
                              store.etiquetaStore.validateEtiqueta,
                          validateColor: store.etiquetaStore.validateColor,
                          validateIcon: store.etiquetaStore.validateIcon)
                      : Container();
                },
              ),
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
