import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/img/top1.png"),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/img/top2.png"),
              ),
              Positioned(
                top: 0,
                right: 20,
                child: Image.asset("assets/img/main.png",
                   ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset("assets/img/bottom1.png"),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset("assets/img/bottom2.png"),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
