// ignore_for_file: prefer_const_constructors

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
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
                                      onChanged: store.changeName,
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
                                  if (store.textFieldNameBool) {
                                    store.save();
                                  }
                                });
                              },
                              child: Icon(
                                store.textFieldNameBool
                                    ? Icons.edit
                                    : Icons.save,
                                color: ThemeData.light().primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 100,
                            child: ListTile(
                              leading: SizedBox(
                                width: 250,
                                child: TextFormField(
                                  initialValue: store.perfil.nameTime,
                                  onChanged: store.changeTime,
                                  decoration: const InputDecoration(
                                    label: Text('Time'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: GestureDetector(
                              child: SizedBox(
                                width: 50,
                                child: Icon(
                                  Icons.save,
                                  color: ThemeData().primaryColor,
                                ),
                              ),
                              onTap: () {
                                store.save();
                              },
                            ),
                          )
                        ],
                      ),
                      ListTile(
                        leading: const Text('Técnico'),
                        title: Switch(
                            value: store.perfil.manager,
                            onChanged: (value) {
                              setState(() {
                                store.changeManager(value);
                                store.save();
                              });
                            }),
                        trailing: const Text('Gerente'),
                      ),
                      Row(
                        children: [
                          store.perfil.manager
                              ? Expanded(
                                  child: Text(
                                    'Equipe',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )
                              : Container(),
                          GestureDetector(
                            child: Icon(
                              Icons.edit,
                              color: ThemeData().primaryColor,
                            ),
                            onTap: () {
                              setState(() {
                                store.setShowTeams(!store.showTeams);
                              });
                            },
                          )
                        ],
                      ),
                      store.showTeams
                          ? Observer(builder: (_) {
                              if (store.usuarios!.data == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (store.usuarios!.hasError) {
                                return Center(
                                  child: ElevatedButton(
                                    onPressed: store.getUsers(),
                                    child: Text('Error ' +
                                        store.usuarios!.error.toString()),
                                  ),
                                );
                              } else {
                                List<UserModel> list = store.usuarios!.data;
                                return Wrap(
                                  alignment: WrapAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  children: [
                                    for (var userModel in list)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InputChip(
                                          avatar: userModel.urlImage != null
                                              ? Image.network(
                                                  userModel.urlImage)
                                              : CircularProgressIndicator(),
                                          label: Text(userModel.name),
                                          onSelected: (bool value) {
                                            store.setIdStaff(
                                                userModel.reference);
                                            store.save();
                                            store.getById();
                                          },
                                        ),
                                      )
                                  ],
                                );
                              }
                            })
                          : store.perfil.manager
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
