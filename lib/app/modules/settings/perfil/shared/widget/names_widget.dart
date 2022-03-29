// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/components/icon_redonded_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class NamesWidget extends StatefulWidget {
  final Function errorTime;
  final bool enableSwitch;

  const NamesWidget({
    Key? key,
    required this.errorTime,
    required this.enableSwitch,
  }) : super(key: key);

  @override
  State<NamesWidget> createState() => _NamesWidgetState();
}

class _NamesWidgetState extends State<NamesWidget>
    with TickerProviderStateMixin {
  bool enabledField = false;
  late AnimationController _controller;
  late Animation<double> _animacaoOpacity;
  final ClientStore client = Modular.get();
  final PerfilStore store = Modular.get();

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
    widget.enableSwitch ? _controller.forward() : _controller.reverse();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        FadeTransition(
          opacity: _animacaoOpacity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: 350,
                    height: 80,
                    child: ListTile(
                      leading: IconRedondedWidget(
                        icon: Icons.admin_panel_settings,
                        color: lightThemeData(context).primaryColor,
                        size: 48,
                      ),
                      title: SizedBox(
                        child: TextFormField(
                          enabled: enabledField,
                          initialValue: client.perfil.nameTime,
                          onChanged: (value) {
                            client.changeTime(value);
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
                            if (!enabledField) {
                              store.saveDio();
                            }
                          });
                        },
                        child: Icon(
                          !enabledField
                              ? Icons.drive_file_rename_outline
                              : Icons.task_alt,
                          color: lightThemeData(context).primaryColor,
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
