import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class CreateUserSubtarefaWidget extends StatefulWidget {
  final dynamic userLista;
  final Function setUserCreateSelection;
  final Function setCreateImageUser;
  const CreateUserSubtarefaWidget({
    Key? key,
    required this.userLista,
    required this.setCreateImageUser,
    required this.setUserCreateSelection,
  }) : super(key: key);

  @override
  State<CreateUserSubtarefaWidget> createState() =>
      _CreateUserSubtarefaWidgetState();
}

class _CreateUserSubtarefaWidgetState extends State<CreateUserSubtarefaWidget>
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
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.9),
      ),
    );
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

                return SingleChildScrollView(
                  child: Wrap(
                    runAlignment: WrapAlignment.spaceAround,
                    spacing: 24,
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
                            width: 70,
                            child: Text(
                              list[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              widget.setUserCreateSelection(list[index]);
                              widget.setCreateImageUser(list[index].urlImage);
                              FocusScope.of(context).unfocus();
                              Modular.to.pop();
                            });
                          },
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
