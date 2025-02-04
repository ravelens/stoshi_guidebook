import 'package:flutter/material.dart';

class HalfCircleOverlay extends StatelessWidget {
  final double height;
  final Color color;

  const HalfCircleOverlay({
    Key? key,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HalfCirclePainter(color),
      size: Size(double.infinity, height),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  final Color color;

  HalfCirclePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path();
    double radius = 80; // Radius of the half circle
    
    path.moveTo(size.width / 2 - radius, 130);
    path.lineTo(size.width / 2 + radius, 130);
    path.quadraticBezierTo(size.width / 2, 30, size.width / 2 - radius, 130);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double radius = 65; // Radius of the half circle

    path.moveTo(size.width / 2 - radius, 86);
    path.lineTo(size.width / 2 + radius, 86);
    path.quadraticBezierTo(size.width / 2, 0, size.width / 2 - radius, 86);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
