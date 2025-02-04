import 'package:flutter/material.dart';
import 'package:stoshi_guildbook/widgets/curved_text.dart';
import 'package:stoshi_guildbook/widgets/custom_clipper.dart';

Widget buildHeaderMenu(BuildContext context, isScrolledPastThreshold,
    isShowLabel, String textShowing) {
  return isScrolledPastThreshold
      ? Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 86,
            color: Color.fromARGB(255, 58, 158, 109),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/door.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment(0, 0.001),
                  ),
                ),
                if (isShowLabel)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: HalfCircleOverlay(
                      height: 130,
                      color: Color.fromARGB(255, 27, 40, 34),
                    ),
                  ),
                if (isShowLabel)
                  Positioned(
                    bottom:
                        30, // Adjust this value to position the text correctly along the curve
                    child: CurvedTextWidget(),
                  ),
              ],
            ),
          ),
        )
      : Container();
}
