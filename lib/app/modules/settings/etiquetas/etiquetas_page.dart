// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
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

          if (store.etiquetaStore.errOrGoal) {
            SnackbarCustom()
                .createSnackBar(store.etiquetaStore.msg, Colors.red, context);
          }
          store.etiquetaStore.setMsg('');
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
          rota: '/home/'),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: LayoutBuilder(
            builder: (context, constraint) {
              double withDevice = constraint.maxWidth;

              if (withDevice < 600) {
                withDevice = withDevice * 1;
              } else if (withDevice < 960) {
                withDevice = withDevice * 0.7;
              } else if (withDevice < 1025) {
                withDevice = withDevice * 0.5;
              } else {
                withDevice = withDevice * 0.4;
              }
              return Center(
                child: SizedBox(
                  width: withDevice,
                  child: Column(
                    children: [
                      SizedBox(
                        height: kIsWeb
                            ? MediaQuery.of(context).size.height * 0.07
                            : MediaQuery.of(context).size.height * 0.05,
                        child: Observer(builder: (_) {
                          return store.etiquetaStore.updateLoading
                              ? FadeTransition(
                                  opacity: opacidade,
                                  child: Padding(
                                    padding: kIsWeb
                                        ? const EdgeInsets.all(8)
                                        : const EdgeInsets.only(left: 12),
                                    child: ElevatedButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.deepPurple),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radius.value),
                                              side: const BorderSide(
                                                color: Colors.deepPurple,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          store.etiquetaStore
                                              .setCleanVariables();
                                          store.etiquetaStore
                                              .setUpdateLoading(false);
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        label: const Text(
                                          'Novo',
                                          style: TextStyle(color: Colors.white),
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
                          reference: store.etiquetaStore.id,
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
                            children: const [
                              ColorsWidget(),
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
                            function: store.submitDio,
                          ),
                        );
                      }),
                      Observer(
                        builder: (_) {
                          return store.etiquetaStore.showValidation
                              ? ValidateWidget(
                                  validateEtiqueta:
                                      store.etiquetaStore.validateEtiqueta,
                                  validateColor:
                                      store.etiquetaStore.validateColor,
                                  validateIcon:
                                      store.etiquetaStore.validateIcon)
                              : Container();
                        },
                      ),
                      Observer(builder: (_) {
                        return store.etiquetaStore.etiquetaDio.isEmpty
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              )
                            : const EtiquetasWidget();
                      })
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
