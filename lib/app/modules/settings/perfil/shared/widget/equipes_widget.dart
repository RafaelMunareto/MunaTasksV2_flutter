import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/components/icon_redonded_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class EquipesWidget extends StatefulWidget {
  final bool enableSwitch;
  const EquipesWidget({
    Key? key,
    required this.enableSwitch,
  }) : super(key: key);

  @override
  State<EquipesWidget> createState() => _EquipesWidgetState();
}

class _EquipesWidgetState extends State<EquipesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoOpacity;
  final ClientStore client = Modular.get();
  final PerfilStore store = Modular.get();

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
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
    widget.enableSwitch ? _controller.forward() : _controller.reverse();
    List<PerfilDioModel> list = client.perfis;
    return FadeTransition(
      opacity: _animacaoOpacity,
      child: Column(
        children: [
          ListTile(
            leading: IconRedondedWidget(
              icon: Icons.groups,
              color: lightThemeData(context).primaryColor,
              size: 42,
            ),
            title: const Text(
              'Equipe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.drive_file_rename_outline,
                color: lightThemeData(context).primaryColor,
              ),
              onTap: () {
                setState(() {
                  client.setShowTeams(!client.showTeams);
                });
              },
            ),
          ),
          client.showTeams
              ? Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: [
                    for (var linha in list)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: InputChip(
                            key: ObjectKey(linha.id),
                            labelPadding: const EdgeInsets.all(2),
                            selected: client.individualChip!.contains(linha.id),
                            elevation: 4.0,
                            avatar: CircleAvatarWidget(
                              url: linha.urlImage,
                            ),
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                linha.name.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onSelected: (bool value) {
                              setState(() {
                                client.individualChip!.contains(linha.id)
                                    ? client.individualChip!.remove(linha.id)
                                    : client.individualChip!.add(linha.id);

                                client.setIdStaff(linha.id);
                                store.saveDio();
                                store.getBydDioId();
                              });
                            },
                          ),
                        ),
                      )
                  ],
                )
              : client.perfilDio.manager
                  ? client.users.isNotEmpty
                      ? Wrap(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          children: [
                            for (var userModel in client.users)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InputChip(
                                  isEnabled: false,
                                  labelPadding: const EdgeInsets.all(2),
                                  elevation: 4.0,
                                  avatar: CircleAvatarWidget(
                                    url: userModel.urlImage,
                                  ),
                                  label: SizedBox(
                                    width: 100,
                                    child: Text(
                                      userModel.name.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  onSelected: (bool value) {},
                                ),
                              )
                          ],
                        )
                      : Container()
                  : Container(),
        ],
      ),
    );
  }
}
