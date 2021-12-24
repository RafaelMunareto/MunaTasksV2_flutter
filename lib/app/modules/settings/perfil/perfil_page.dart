import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/widget/imagem_perfil_widget.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/widget/names_widget.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          context: context,
          icon: Icons.account_circle,
          settings: true,
          rota: '/home',
          back: true),
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) {
            if (store.client.loading) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: [
                    ImagemPerfilWidget(
                        loadingImagem: store.client.loadingImagem,
                        setLoadingImagem: store.client.setLoadingImagem,
                        perfil: store.client.perfil,
                        userModel: store.client.userModel,
                        getById: store.getById,
                        atualizarUrlImagemPerfilProfile: store
                            .imageRepository.atualizarUrlImagemPerfilProfile,
                        textFieldNameBool: store.client.textFieldNameBool,
                        changeName: store.client.changeName,
                        save: store.save,
                        showTextFieldName: store.client.showTextFieldName,
                        errorName: store.client.validateName),
                    NamesWidget(
                        textFieldNameBool: store.client.textFieldNameBool,
                        perfil: store.client.perfil,
                        changeName: store.client.changeName,
                        save: store.save,
                        showTextFieldName: store.client.showTextFieldName,
                        changeTime: store.client.changeTime,
                        errorTime: store.client.validateTime,
                        changeManager: store.client.changeManager),
                    // Row(
                    //   children: [
                    //     store.client.perfil.manager
                    //         ? const Expanded(
                    //             child: Text(
                    //               'Equipe',
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold, fontSize: 18),
                    //             ),
                    //           )
                    //         : Container(),
                    //     GestureDetector(
                    //       child: Icon(
                    //         Icons.edit,
                    //         color: ThemeData().primaryColor,
                    //       ),
                    //       onTap: () {
                    //         setState(() {
                    //           store.client.setShowTeams(!store.client.showTeams);
                    //         });
                    //       },
                    //     )
                    //   ],
                    // ),
                    // EquipesWidget(
                    //     showTeams: store.client.showTeams,
                    //     usuarios: store.client.usuarios,
                    //     getUsers: store.getUsers,
                    //     individualChip: store.client.individualChip,
                    //     setIdStaff: store.client.setIdStaff,
                    //     perfil: store.client.perfil,
                    //     getById: store.getById,
                    //     users: store.client.userModel,
                    //     inputChipChecked: store.client.inputChipChecked,
                    //     save: store.save)
                  ],
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
