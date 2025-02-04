import 'dart:math';

import 'package:flutter/material.dart';

class CurvedTextPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;

  CurvedTextPainter({required this.text, required this.textStyle});

  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final center = Offset(size.width / 2, size.height / 2);

    // Example of manually positioning and drawing text, adjust to bend along a path
    const startAngle = -90.0;
    const radius = 100.0;
    for (int i = 0; i < text.length; i++) {
      var c = text[i];
      var angle = startAngle + i * 10; // Adjust angle per character
      var x = center.dx + radius * cos(angle * pi / 180);
      var y = center.dy + radius * sin(angle * pi / 180);

      textPainter.text = TextSpan(text: c, style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas,
          Offset(x - textPainter.width / 2, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CurvedTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurvedTextPainter(
        text: "Hello Curved World!",
        textStyle: TextStyle(color: Colors.black, fontSize: 24),
      ),
      size: Size(400, 400),
    );
  }
}
