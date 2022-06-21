import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/users_selection_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

class UsersSaveWidget extends StatefulWidget {
  final double constraint;
  const UsersSaveWidget({Key? key, required this.constraint}) : super(key: key);

  @override
  State<UsersSaveWidget> createState() => _UsersSaveWidgetState();
}

class _UsersSaveWidgetState extends State<UsersSaveWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Center(
          child: SizedBox(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                if (store.clientCreate.users.isEmpty &
                    !store.clientCreate.loadingUser)
                  GestureDetector(
                    onTap: () => DialogButtom().showDialog(
                        UsersSelectionWidget(
                          constraint: widget.constraint,
                          subtarefa: false,
                        ),
                        store.client.theme,
                        widget.constraint,
                        context),
                    child: const Text(
                      'Equipe',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (store.clientCreate.users.isNotEmpty &&
                    !store.clientCreate.loadingUser)
                  for (var linha in store.clientCreate.users)
                    Baseline(
                      baseline: 38,
                      baselineType: TextBaseline.alphabetic,
                      child: GestureDetector(
                        onTap: () => DialogButtom().showDialog(
                          UsersSelectionWidget(
                            constraint: widget.constraint,
                            subtarefa: false,
                          ),
                          store.client.theme,
                          widget.constraint,
                          context,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          child: GestureDetector(
                            onTap: () => DialogButtom().showDialog(
                              UsersSelectionWidget(
                                constraint: widget.constraint,
                                subtarefa: false,
                              ),
                              store.client.theme,
                              widget.constraint,
                              context,
                            ),
                            child: CircleAvatarWidget(
                              nameUser: linha.name.name,
                              key: Key(linha.id),
                              url: linha.urlImage,
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
