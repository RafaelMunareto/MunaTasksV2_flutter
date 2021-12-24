import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/shared/components/custom_switch_widget.dart';
import 'package:munatasks2/app/shared/components/icon_redonded_widget.dart';

class NamesWidget extends StatefulWidget {
  final bool textFieldNameBool;
  final PerfilModel perfil;
  final Function changeName;
  final Function save;
  final Function showTextFieldName;
  final Function changeTime;
  final Function errorTime;
  final Function changeManager;

  const NamesWidget(
      {Key? key,
      required this.textFieldNameBool,
      required this.perfil,
      required this.changeName,
      required this.save,
      required this.showTextFieldName,
      required this.changeTime,
      required this.errorTime,
      required this.changeManager})
      : super(key: key);

  @override
  State<NamesWidget> createState() => _NamesWidgetState();
}

class _NamesWidgetState extends State<NamesWidget>
    with TickerProviderStateMixin {
  bool enabledField = false;
  late AnimationController _controller;
  late Animation<double> _animacaoOpacity;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
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
    bool enableSwitch = widget.perfil.manager;
    enableSwitch ? _controller.forward() : _controller.reverse();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: CustomSwitchWidget(switched: enableSwitch),
          onTap: () {
            setState(() {
              widget.changeManager(!enableSwitch);
            });
            widget.save();
          },
          behavior: HitTestBehavior.translucent,
        ),
        FadeTransition(
          opacity: _animacaoOpacity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: 350,
                    height: 80,
                    child: ListTile(
                      leading: IconRedondedWidget(
                        icon: Icons.admin_panel_settings,
                        color: ThemeData().primaryColor,
                        size: 48,
                      ),
                      title: SizedBox(
                        child: TextFormField(
                          enabled: enabledField,
                          initialValue: widget.perfil.nameTime,
                          onChanged: (value) {
                            widget.changeTime(value);
                          },
                          decoration: InputDecoration(
                            filled: enabledField,
                            label: const Text('Time'),
                            errorText: widget.errorTime == null
                                ? null
                                : widget.errorTime(),
                          ),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            enabledField = !enabledField;
                          });
                        },
                        child: Icon(
                          !enabledField
                              ? Icons.drive_file_rename_outline
                              : Icons.task_alt,
                          color: ThemeData().primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
