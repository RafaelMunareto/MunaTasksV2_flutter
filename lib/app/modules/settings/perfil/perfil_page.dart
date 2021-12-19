// ignore_for_file: prefer_const_constructors

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/button_widget.dart';

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
                            : CircularProgressIndicator(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                  child: Icon(Icons.camera_alt,
                                      color: Colors.deepPurple, size: 48),
                                  onTap: () {
                                    store.recuperarImagem("camera");
                                  })),
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                  child: Icon(Icons.image,
                                      color: Colors.deepPurple, size: 48),
                                  onTap: () {
                                    store.recuperarImagem("galeria");
                                  })),
                        ],
                      ),
                      Chip(label: Text(store.perfil.name)),
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
                                          avatar:
                                              Image.network(userModel.urlImage),
                                          label: Text(userModel.name),
                                          onSelected: (bool value) {},
                                        ),
                                      )
                                  ],
                                )
                              : Container()
                          : Container(),
                      const ButtonWidget(
                        label: 'Editar',
                      )
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
