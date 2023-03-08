import 'package:flutter/material.dart';

class LineDashedPainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final int numDashes;
  final Color color;

  LineDashedPainter({
    required this.dashWidth,
    required this.dashSpace,
    required this.numDashes,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = size.height
      ..color = color;
    var max = numDashes * (dashWidth + dashSpace);
    double startX = 0;
    while (max >= 0) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
      max -= dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(LineDashedPainter oldDelegate) {
    return oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.numDashes != numDashes ||
        oldDelegate.color != color;
  }
}
