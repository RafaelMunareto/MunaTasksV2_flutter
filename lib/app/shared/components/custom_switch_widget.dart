import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _SwitchBoxProps { paddingLeft, color, text, rotation }

class CustomSwitchWidget extends StatelessWidget {
  final bool switched;

  const CustomSwitchWidget({Key? key, required this.switched})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tween = MultiTween<_SwitchBoxProps>()
      ..add(_SwitchBoxProps.paddingLeft, 0.0.tweenTo(200.0), 800.milliseconds)
      ..add(_SwitchBoxProps.color, Colors.grey.tweenTo(Colors.blue),
          800.milliseconds)
      ..add(_SwitchBoxProps.text, ConstantTween("TEC"), 800.milliseconds)
      ..add(_SwitchBoxProps.text, ConstantTween("GER"), 800.milliseconds)
      ..add(_SwitchBoxProps.rotation, (-2 * pi).tweenTo(0.0), 900.milliseconds);

    return CustomAnimation<MultiTweenValues<_SwitchBoxProps>>(
      control: switched
          ? CustomAnimationControl.play
          : CustomAnimationControl.playReverse,
      startPosition: switched ? 1.0 : 0.0,
      duration: tween.duration * 1.2,
      tween: tween,
      curve: Curves.easeInOut,
      builder: _buildSwitchBox,
    );
  }

  Widget _buildSwitchBox(
      context, child, MultiTweenValues<_SwitchBoxProps> value) {
    return Container(
      decoration: _outerBoxDecoration(value.get(_SwitchBoxProps.color)),
      width: 200,
      height: 40,
      padding: const EdgeInsets.all(3.0),
      child: Stack(
        children: [
          Positioned(
              child: Padding(
            padding:
                EdgeInsets.only(left: value.get(_SwitchBoxProps.paddingLeft)),
            child: Transform.rotate(
              angle: value.get(_SwitchBoxProps.rotation),
              child: Container(
                decoration:
                    _innerBoxDecoration(value.get(_SwitchBoxProps.color)),
                width: 30,
                child: Center(
                    child: Text(value.get(_SwitchBoxProps.text),
                        style: labelStyle)),
              ),
            ),
          ))
        ],
      ),
    );
  }

  BoxDecoration _innerBoxDecoration(Color color) => BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(25)), color: color);

  BoxDecoration _outerBoxDecoration(Color color) => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(
          width: 2,
          color: color,
        ),
      );

  // ignore: prefer_const_constructors
  static final labelStyle = TextStyle(
      height: 1.3,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.white);
}
