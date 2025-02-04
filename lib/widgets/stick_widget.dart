import 'package:flutter/material.dart';

Widget buildAnimatedSticks(
  _animation1,
  _animation2,
  _animation3,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      buildAnimatedStick(_animation1, true), // True for upwards
      buildAnimatedStick(_animation2, false), // False for downwards
      buildAnimatedStick(_animation3, true), // True for upwards again
    ],
  );
}

Widget buildAnimatedStick(Animation<double> animation, bool isUpwards) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      return Transform.translate(
        offset: Offset(0, isUpwards ? -animation.value : animation.value),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isUpwards)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(radius: 10, backgroundColor: Colors.red),
                  Container(width: 10, height: 100, color: Colors.blue),
                ],
              ),
            if (isUpwards)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 10, height: 100, color: Colors.blue),
                  CircleAvatar(radius: 10, backgroundColor: Colors.red),
                ],
              ),
          ],
        ),
      );
    },
  );
}
