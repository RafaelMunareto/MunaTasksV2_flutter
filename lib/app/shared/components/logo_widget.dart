import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class LogoWidget extends StatelessWidget {
  final double heigth;
  final double width;
  final double constraint;
  const LogoWidget(
      {Key? key,
      required this.constraint,
      this.heigth = 0.15,
      this.width = 0.4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * heigth,
        width: constraint < LarguraLayoutBuilder().telaPc
            ? MediaQuery.of(context).size.width * width
            : MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icon/icon.png'),
            opacity: 0.07,
          ),
        ),
      ),
    );
  }
}
