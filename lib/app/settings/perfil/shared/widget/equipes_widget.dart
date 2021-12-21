import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

class EquipesWidget extends StatefulWidget {
  final bool showTeams;
  final Function getUsers;
  final ObservableStream<List<UserModel>>? usuarios;
  final List<int>? individualChip;
  final Function setIdStaff;
  final Function save;
  final PerfilModel perfil;
  final List<dynamic>? users;
  final Function getById;
  final Function inputChipChecked;
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
      required this.save})
      : super(key: key);

  @override
  State<EquipesWidget> createState() => _EquipesWidgetState();
}

class _EquipesWidgetState extends State<EquipesWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.showTeams
        ? Observer(builder: (_) {
            if (widget.usuarios!.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (widget.usuarios!.hasError) {
              return Center(
                child: ElevatedButton(
                  onPressed: widget.getUsers(),
                  child: Text('Error ' + widget.usuarios!.error.toString()),
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
                            child: InputChip(
                              key: ObjectKey(list[i].reference),
                              selected: widget.individualChip!.contains(i),
                              avatar: Image.network(list[i].urlImage),
                              label: Text(
                                list[i].name,
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
                            avatar: Image.network(userModel.urlImage),
                            label: Text(userModel.name),
                            onSelected: (bool value) {},
                          ),
                        )
                    ],
                  )
                : Container()
            : Container();
  }
}
