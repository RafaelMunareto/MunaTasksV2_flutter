import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class TeamsSelectionWidget extends StatefulWidget {
  const TeamsSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TeamsSelectionWidget> createState() => _TeamsSelectionWidgetState();
}

class _TeamsSelectionWidgetState extends State<TeamsSelectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoOpacity;
  final HomeStore store = Modular.get();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animacaoOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.9)));
    _controller.forward();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: _buildAnimation,
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    List<PerfilDioModel> list = store.client.perfis;
    var todos = PerfilDioModel(
        name: UserDioClientModel(
            name: "TODOS", email: "todos@todos.com.br", password: ""),
        nameTime: "",
        idStaff: [],
        manager: true,
        urlImage: DioStruture().baseUrlMunatasks + 'files/todos.png');
    if (!list.map((e) => e.name.name.contains('TODOS')).contains(true)) {
      list.insert(0, todos);
    }

    return FadeTransition(
      opacity: _animacaoOpacity,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: Wrap(
              runAlignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 24,
              children: [
                for (var linha in list)
                  Padding(
                    padding: constraint.maxWidth >
                            LarguraLayoutBuilder().larguraModal
                        ? const EdgeInsets.only(bottom: 16.0)
                        : const EdgeInsets.only(bottom: 16.0),
                    child: InputChip(
                      key: ObjectKey(linha.id),
                      labelPadding: const EdgeInsets.all(2),
                      elevation: 4.0,
                      avatar: linha.urlImage == null
                          ? const CircularProgressIndicator()
                          : CircleAvatarWidget(
                              nameUser: '',
                              url: linha.urlImage,
                            ),
                      label: SizedBox(
                        width: 100,
                        child: Text(
                          linha.name.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      onPressed: () {
                        if (store.clientCreate.editar) {
                          store.clientCreate.setUserCreateSelection(linha);
                          store.clientCreate.setCreateImageUser(linha.urlImage);
                          store.clientCreate.setLoadingUser(false);
                          Modular.to.pop();
                        } else {
                          store.client.setUserSelection(linha);
                          store.changeFilterUserList();
                          store.client.setImgUrl(linha.urlImage);
                          Modular.to.pop();
                        }
                      },
                    ),
                  ),
              ],
            ),
          );
        })),
      ),
    );
  }
}
