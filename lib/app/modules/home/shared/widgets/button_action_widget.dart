import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class ButtonActionWidget extends StatelessWidget {
  const ButtonActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.88,
            child: Divider(
              height: 6,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print('oi');
                  },
                  child: const Icon(
                    Icons.play_circle,
                    color: Colors.yellow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('oi');
                  },
                  child: const Icon(
                    Icons.task_alt,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      print('oi');
                    },
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
