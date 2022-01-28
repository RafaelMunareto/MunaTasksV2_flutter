import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';

class UsersSelectionWidget extends StatefulWidget {
  final dynamic userList;
  final Function setSaveIdStaff;
  final dynamic saveIdStaff;
  final List<dynamic>? individualChip;
  final Function setIdReferenceStaff;
  const UsersSelectionWidget({
    Key? key,
    required this.userList,
    this.individualChip,
    required this.saveIdStaff,
    required this.setSaveIdStaff,
    required this.setIdReferenceStaff,
  }) : super(key: key);

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
    return FadeTransition(
      opacity: _animacaoOpacity,
      child: Wrap(
        direction: Axis.vertical,
        children: [
          Observer(
            builder: (_) {
              if (widget.userList!.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (widget.userList!.hasError) {
                return Center(
                  child: Text('Error ' + widget.userList!.error.toString()),
                );
              } else {
                List<UserModel> list = widget.userList!.data;
                return list.isNotEmpty
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Wrap(
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
                                      child: Text(
                                        list[i].name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    onSelected: (bool value) {
                                      setState(() {
                                        widget.setIdReferenceStaff(
                                            list[i].reference);
                                        widget.setSaveIdStaff(list[i]);
                                      });
                                      print(widget.saveIdStaff);
                                    },
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                    : Container();
              }
            },
          )
        ],
      ),
    );
  }
}
