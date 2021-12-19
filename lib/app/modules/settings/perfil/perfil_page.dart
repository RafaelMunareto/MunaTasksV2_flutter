// ignore_for_file: prefer_const_constructors

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';

class PerfilPage extends StatefulWidget {
  final String title;
  const PerfilPage({Key? key, this.title = 'Perfil'}) : super(key: key);
  @override
  PerfilPageState createState() => PerfilPageState();
}

class PerfilPageState extends State<PerfilPage> {
  final PerfilStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          context: context,
          size: altura,
          settings: true,
          rota: '/home',
          back: true),
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) {
            if (store.loading) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Center(
                        child: !store.loadingImagem
                            ? Container(
                                width: 190.0,
                                height: 190.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(store.perfil.urlImage),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 190,
                                height: 190,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                  child: Icon(Icons.camera_alt,
                                      color: ThemeData.light().primaryColor,
                                      size: 48),
                                  onTap: () {
                                    store.recuperarImagem("camera");
                                  })),
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                  child: Icon(Icons.image,
                                      color: ThemeData.light().primaryColor,
                                      size: 48),
                                  onTap: () {
                                    store.recuperarImagem("galeria");
                                  })),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Observer(builder: (_) {
                            print(store.textFieldNameBool);
                            return store.textFieldNameBool
                                ? SizedBox(
                                    width: 200,
                                    child: Chip(
                                      label: Text(store.perfil.name),
                                    ),
                                  )
                                : SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      initialValue: store.perfil.name,
                                      decoration: const InputDecoration(
                                        label: Text('Nome'),
                                      ),
                                    ),
                                  );
                          }),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  store.showTextFieldName(
                                      !store.textFieldNameBool);
                                });
                              },
                              child: Icon(
                                Icons.edit,
                                color: ThemeData.light().primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      TextFormField(
                        initialValue: store.perfil.nameTime,
                        decoration: const InputDecoration(
                          label: Text('Time'),
                        ),
                      ),
                      ListTile(
                        leading: const Text('Técnico'),
                        title: Switch(
                            value: store.perfil.manager,
                            onChanged: (value) async {}),
                        trailing: const Text('Gerente'),
                      ),
                      Row(
                        children: [
                          store.perfil.manager
                              ? Expanded(
                                  child: Text(
                                    'Equipe',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      store.perfil.manager
                          ? store.userModel.isNotEmpty
                              ? Wrap(
                                  alignment: WrapAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  children: [
                                    for (var userModel in store.userModel)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InputChip(
                                          avatar: userModel.urlImage != null
                                              ? Image.network(
                                                  userModel.urlImage)
                                              : CircularProgressIndicator(),
                                          label: Text(userModel.name),
                                          onSelected: (bool value) {},
                                        ),
                                      )
                                  ],
                                )
                              : Container()
                          : Container(),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
