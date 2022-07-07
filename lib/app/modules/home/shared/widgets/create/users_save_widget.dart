import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/create/users_selection_widget.dart';
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
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            if (store.clientCreate.users.isEmpty &
                !store.clientCreate.loadingUser)
              GestureDetector(
                  onTap: () {
                    store.clientCreate.setSubtarefaAction(false);
                    DialogButtom().showDialog(
                        UsersSelectionWidget(
                          constraint: widget.constraint,
                        ),
                        store.client.theme,
                        widget.constraint,
                        context);
                  },
                  child: const Icon(
                    Icons.people,
                    color: Colors.black,
                  )),
            if (store.clientCreate.users.isNotEmpty &&
                !store.clientCreate.loadingUser)
              for (var linha in store.clientCreate.users)
                GestureDetector(
                    onTap: () {
                      store.clientCreate.setSubtarefaAction(false);
                      DialogButtom().showDialog(
                        UsersSelectionWidget(
                          constraint: widget.constraint,
                        ),
                        store.client.theme,
                        widget.constraint,
                        context,
                      );
                    },
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
                        child: CircleAvatarWidget(
                          nameUser: linha.name.name,
                          key: Key(linha.id),
                          url: linha.urlImage,
                        ))),
          ],
        );
      },
    );
  }
}
