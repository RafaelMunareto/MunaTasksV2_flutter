import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class TeamsSelectionWidget extends StatefulWidget {
  final dynamic userLista;
  final Function changeFilterUserList;
  final Function? setUserSelection;
  final Function setImageUser;
  const TeamsSelectionWidget({
    Key? key,
    required this.userLista,
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
    return FadeTransition(
      opacity: _animacaoOpacity,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
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
                return SingleChildScrollView(
                  child: Wrap(
                    runAlignment: WrapAlignment.spaceAround,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 24,
                    children: [
                      for (var index = 0; index < list.length; index++)
                        Padding(
                          padding: kIsWeb
                              ? const EdgeInsets.only(bottom: 16.0)
                              : const EdgeInsets.only(bottom: 4.0),
                          child: InputChip(
                            key: ObjectKey(list[index].reference),
                            labelPadding: const EdgeInsets.all(2),
                            elevation: 4.0,
                            avatar: CircleAvatarWidget(
                              url: list[index].urlImage,
                            ),
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                list[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                widget.setUserSelection!(list[index]);
                                widget.changeFilterUserList();
                                widget.setImageUser(list[index].urlImage);
                                Modular.to.pop();
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
