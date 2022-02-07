import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class UsersSelectionWidget extends StatefulWidget {
  const UsersSelectionWidget({Key? key}) : super(key: key);

  @override
  State<UsersSelectionWidget> createState() => _UsersSelectionWidgetState();
}

class _UsersSelectionWidgetState extends State<UsersSelectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoOpacity;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
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
    final HomeStore store = Modular.get();
    return FadeTransition(
      opacity: _animacaoOpacity,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Observer(
            builder: (_) {
              if (store.client.userList!.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (store.client.userList!.hasError) {
                return Center(
                  child:
                      Text('Error ' + store.client.userList!.error.toString()),
                );
              } else {
                List<UserModel> list = store.client.userList!.data;
                return list.isNotEmpty
                    ? SingleChildScrollView(
                        child: Wrap(
                          runAlignment: WrapAlignment.spaceBetween,
                          spacing: 24,
                          children: [
                            for (var i = 0; i < list.length; i++)
                              SizedBox(
                                child: InputChip(
                                  key: ObjectKey(list[i].email),
                                  labelPadding: const EdgeInsets.all(2),
                                  selected: store.clientCreate.individualChip
                                      .contains(list[i].email),
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
                                      store.clientCreate
                                          .setIdReferenceStaff(list[i].email);
                                      store.clientCreate.setIdStaff(list[i]);
                                      FocusScope.of(context).unfocus();
                                      store.clientCreate.setLoadingUser(false);
                                    });
                                  },
                                ),
                              ),
                            Baseline(
                              baseline: 100,
                              baselineType: TextBaseline.alphabetic,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  onPressed: () {
                                    Modular.to.pop();
                                  },
                                  child: const Text('FECHAR'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
