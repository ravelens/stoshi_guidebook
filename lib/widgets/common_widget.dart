import 'package:flutter/material.dart';

Widget componentText(text) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Stack(
        children: <Widget>[
          // Stroked text as the base layer.
          Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Color.fromARGB(255, 170, 156, 28),
            ),
          ),
          // Solid text as the top layer.
          Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
