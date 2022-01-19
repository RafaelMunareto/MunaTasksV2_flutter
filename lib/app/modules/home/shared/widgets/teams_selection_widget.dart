import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class TeamsSelectionWidget extends StatefulWidget {
  final dynamic userLista;
  final Function changeFilterUserList;
  final Function? setUserSelection;
  final Function setImageUser;
  final Function setClosedListUserExpanded;
  const TeamsSelectionWidget({
    Key? key,
    required this.userLista,
    required this.changeFilterUserList,
    required this.setUserSelection,
    required this.setImageUser,
    required this.setClosedListUserExpanded,
  }) : super(key: key);

  @override
  State<TeamsSelectionWidget> createState() => _TeamsSelectionWidgetState();
}

class _TeamsSelectionWidgetState extends State<TeamsSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Observer(
        builder: (_) {
          if (widget.userLista!.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<UserModel> list = widget.userLista!.data;
            var todos = UserModel(
                name: 'TODOS',
                email: 'todos@todos.com.br',
                urlImage:
                    'https://firebasestorage.googleapis.com/v0/b/munatasksv2.appspot.com/o/allPeople.png?alt=media&token=19a38226-7467-4f83-a201-20214af45bc1');
            if (!list.map((e) => e.name.contains('TODOS')).contains(true)) {
              list.insert(0, todos);
            }
            return Wrap(
              runAlignment: WrapAlignment.spaceAround,
              spacing: 16,
              children: [
                for (var index = 0; index < list.length; index++)
                  InputChip(
                    key: ObjectKey(list[index].reference),
                    labelPadding: const EdgeInsets.all(2),
                    elevation: 4.0,
                    avatar: CircleAvatarWidget(
                      url: list[index].urlImage,
                    ),
                    label: SizedBox(
                      child: Text(
                        list[index].name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.setUserSelection!(list[index].name);
                        widget.changeFilterUserList();
                        widget.setImageUser(list[index].urlImage);
                        widget.setClosedListUserExpanded(true);
                      });
                    },
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
