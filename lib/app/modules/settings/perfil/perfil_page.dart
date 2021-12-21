// ignore_for_file: prefer_const_constructors

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/settings/perfil/shared/widget/equipes_widget.dart';
import 'package:munatasks2/app/settings/perfil/shared/widget/imagem_perfil_widget.dart';
import 'package:munatasks2/app/settings/perfil/shared/widget/names_widget.dart';
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
                      ImagemPerfilWidget(
                        loadingImagem: store.loadingImagem,
                        perfil: store.perfil,
                        recuperarImagem: store.recuperarImagem,
                      ),
                      NamesWidget(
                          textFieldNameBool: store.textFieldNameBool,
                          perfil: store.perfil,
                          changeName: store.changeName,
                          save: store.save,
                          showTextFieldName: store.showTextFieldName,
                          changeTime: store.changeTime,
                          changeManager: store.changeManager),
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
                      EquipesWidget(
                          showTeams: store.showTeams,
                          usuarios: store.usuarios,
                          getUsers: store.getUsers,
                          individualChip: store.individualChip,
                          setIdStaff: store.setIdStaff,
                          perfil: store.perfil,
                          getById: store.getById,
                          users: store.userModel,
                          inputChipChecked: store.inputChipChecked,
                          save: store.save)
                    ],
                  ),
                ),
              );
            } else {
              return Center(
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
