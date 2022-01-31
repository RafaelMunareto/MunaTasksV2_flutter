import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/users_selection_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class UsersSaveWidget extends StatefulWidget {
  const UsersSaveWidget({Key? key}) : super(key: key);

  @override
  State<UsersSaveWidget> createState() => _UsersSaveWidgetState();
}

class _UsersSaveWidgetState extends State<UsersSaveWidget> {
  final HomeStore store = Modular.get();

  users() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: const Text('OK'),
            ),
          ],
          title: const Text('Responsáveis'),
          content: const UsersSelectionWidget(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Wrap(
          children: [
            if (store.clientCreate.users.isEmpty & !store.clientCreate.loading)
              GestureDetector(
                onTap: () => users(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
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
                !store.clientCreate.loading)
              for (var i = 0; i < store.clientCreate.users.length; i++)
                GestureDetector(
                  onTap: () => users(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 2),
                    child: GestureDetector(
                      onTap: () => users(),
                      child: CircleAvatarWidget(
                          key: Key(
                              store.clientCreate.users[i].reference.toString()),
                          url: store.clientCreate.users[i].urlImage.toString()),
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }
}
