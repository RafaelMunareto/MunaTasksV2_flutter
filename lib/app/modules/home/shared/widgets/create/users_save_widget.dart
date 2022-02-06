import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/users_selection_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';

class UsersSaveWidget extends StatefulWidget {
  const UsersSaveWidget({Key? key}) : super(key: key);

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
                onTap: () => DialogButtom()
                    .showDialog(const UsersSelectionWidget(), context),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                  child: Chip(
                    label: Text('Equipe'),
                    avatar: Icon(
                      Icons.people,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            if (store.clientCreate.users.isNotEmpty &&
                !store.clientCreate.loadingUser)
              for (var i = 0; i < store.clientCreate.users.length; i++)
                Baseline(
                  baseline: 38,
                  baselineType: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: () => DialogButtom()
                        .showDialog(const UsersSelectionWidget(), context),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: GestureDetector(
                        onTap: () => DialogButtom()
                            .showDialog(const UsersSelectionWidget(), context),
                        child: CircleAvatarWidget(
                            key: Key(store.clientCreate.users[i].reference
                                .toString()),
                            url: store.clientCreate.users[i].urlImage
                                .toString()),
                      ),
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }
}
