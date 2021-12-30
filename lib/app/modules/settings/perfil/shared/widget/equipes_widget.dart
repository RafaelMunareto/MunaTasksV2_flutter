import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/components/icon_redonded_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class EquipesWidget extends StatefulWidget {
  final bool showTeams;
  final Function getUsers;
  final ObservableStream<List<UserModel>>? usuarios;
  final List<dynamic>? individualChip;
  final Function setIdStaff;
  final Function save;
  final PerfilModel perfil;
  final List<dynamic>? users;
  final Function getById;
  final Function inputChipChecked;
  final Function setShowTeams;
  final bool enableSwitch;
  const EquipesWidget(
      {Key? key,
      this.showTeams = false,
      required this.usuarios,
      required this.getUsers,
      required this.individualChip,
      required this.setIdStaff,
      required this.perfil,
      required this.users,
      required this.getById,
      required this.inputChipChecked,
      required this.setShowTeams,
      required this.enableSwitch,
      required this.save})
      : super(key: key);

  @override
  State<EquipesWidget> createState() => _EquipesWidgetState();
}

class _EquipesWidgetState extends State<EquipesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoOpacity;

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
                  widget.setShowTeams(!widget.showTeams);
                });
              },
            ),
          ),
          widget.showTeams
              ? Observer(builder: (_) {
                  if (widget.usuarios!.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (widget.usuarios!.hasError) {
                    return Center(
                      child: Wrap(
                        children: [
                          ElevatedButton(
                            onPressed: widget.getUsers(),
                            child: Text(
                                'Error ' + widget.usuarios!.error.toString()),
                          ),
                        ],
                      ),
                    );
                  } else {
                    List<UserModel> list = widget.usuarios!.data;
                    return list.isNotEmpty
                        ? Wrap(
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            children: [
                              for (var i = 0; i < list.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: InputChip(
                                      key: ObjectKey(list[i].reference),
                                      labelPadding: const EdgeInsets.all(2),
                                      selected: widget.individualChip!
                                          .contains(list[i].reference),
                                      elevation: 4.0,
                                      avatar: CircleAvatarWidget(
                                        url: list[i].urlImage,
                                      ),
                                      label: SizedBox(
                                        width: 100,
                                        child: Text(
                                          list[i].name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      onSelected: (bool value) {
                                        setState(() {
                                          widget.individualChip!.contains(i)
                                              ? widget.individualChip!.remove(i)
                                              : widget.individualChip!.add(i);

                                          widget.setIdStaff(list[i].reference);
                                          widget.save();
                                          widget.getById();
                                        });
                                      },
                                    ),
                                  ),
                                )
                            ],
                          )
                        : Container();
                  }
                })
              : widget.perfil.manager
                  ? widget.users!.isNotEmpty
                      ? Wrap(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          children: [
                            for (var userModel in widget.users!)
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
                                      userModel.name,
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
