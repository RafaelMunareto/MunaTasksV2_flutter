import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class TeamsSelectionWidget extends StatefulWidget {
  final Function changeFilterUserList;
  final Function? setUserSelection;
  final Function setImageUser;
  const TeamsSelectionWidget({
    Key? key,
    required this.changeFilterUserList,
    required this.setUserSelection,
    required this.setImageUser,
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
        urlImage:
            'https://firebasestorage.googleapis.com/v0/b/munatasksv2.appspot.com/o/allPeople.png?alt=media&token=19a38226-7467-4f83-a201-20214af45bc1');
    if (!list.map((e) => e.name.name.contains('TODOS')).contains(true)) {
      list.insert(0, todos);
    }

    return FadeTransition(
      opacity: _animacaoOpacity,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Wrap(
              runAlignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 24,
              children: [
                for (var linha in list)
                  Padding(
                    padding: kIsWeb || Platform.isWindows
                        ? const EdgeInsets.only(bottom: 16.0)
                        : const EdgeInsets.only(bottom: 4.0),
                    child: InputChip(
                      key: ObjectKey(linha.id),
                      labelPadding: const EdgeInsets.all(2),
                      elevation: 4.0,
                      avatar: CircleAvatarWidget(
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
                        setState(() {
                          widget.setUserSelection!(linha);
                          widget.changeFilterUserList();
                          widget.setImageUser(linha.urlImage);
                          Modular.to.pop();
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
