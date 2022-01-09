import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/colors_widget.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/etiquetas_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/button_widget.dart';
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
  Icon? _icon;

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      title: const Text('Escolha um ícone'),
      searchHintText: 'Pesquisar',
      closeChild: const Text('Fechar',textScaleFactor: 1.25,)
      iconPackModes: [IconPack.material],
    );
    setState(() {
      if(icon != null){
        store.setIcon(icon.codePoint);
      }
    });
    
    store.icon != null ? 
    _icon = Icon(icon) : _icon = Icon(
                          IconData(store.icon ?? 0,
                              fontFamily: 'MaterialIcons'),);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        if (store.msg != '') {
          SnackbarCustom().createSnackBar(store.msg, Colors.green, context);
          store.setMsg('');
          if (store.errOrGoal) {
            SnackbarCustom().createSnackBar(store.msg, Colors.red, context);
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
            store.setColorAction(false);
          },
          child: Wrap(
            direction: Axis.vertical,
            children: [
              
                 SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Observer(builder: (_) {
                    return TextFormField(
                       key: Key(store.etiqueta),
                      initialValue: store.etiqueta,
                      onChanged:store.changeEtiqueta,
                      decoration: InputDecoration(
                        label: const Text('Etiqueta'),
                        icon: const Icon(Icons.bookmark),
                        // ignore: unnecessary_null_comparison
                        errorText: store.validateEtiqueta == null
                            ? null
                            : store.validateEtiqueta(),
                      ),
                    );
                    }),
                  ),
                ),
                    
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: const ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Escolha uma ícone'),
                        ),
                        onTap: _pickIcon,
                      ),
                      const SizedBox(height: 10),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _icon ?? Container(),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                    child: GestureDetector(
                      child: const ListTile(
                        leading: Icon(Icons.color_lens, color: Colors.deepPurple,),
                        title: Text('Escolha uma cor', style: TextStyle(color: Colors.deepPurple),),
                      ),
                      onTap: () {
                        setState(
                          () {
                             FocusScope.of(context).requestFocus(FocusNode());
                            store.setColorAction(!store.colorAction);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              Observer(
                builder: (_) {
                  return ColorsWidget(
                    colorAction: store.colorAction,
                    colorsList: store.colorsList,
                    getColors: store.getColors,
                    color: store.color,
                    setColor: store.setColor,
                  );
                },
              ),
              Observer(builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                      label: store.updateLoading ? 'ATUALIZAR' : 'SALVAR',
                      width: MediaQuery.of(context).size.width * 0.5,
                      loading: store.loading,
                      function: store.isValidateEtiqueta ? store.submit : null),
                );
              }),
              EtiquetasWidget(etiquetasList: store.etiquetaList, getList: store.getList, delete: store.delete, loadingUpdate: store.loadingUpdate,),
            ],
          ),
        ),
      ),
    );
  }
}
