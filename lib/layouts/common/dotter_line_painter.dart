import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class DottedLinePainter extends CustomPainter {
  DottedLinePainter({
    this.lineWidth = 5,
    this.xLinePadding = 4,
    this.yLinePadding = 3,
  });

  final double lineWidth;
  final double xLinePadding;
  final double yLinePadding;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final Paint paint = Paint()..color = AppColors.primaryColor;
    double xUnit = 0;
    double yUnit = 0;
    while (yUnit < size.height) {
      canvas.drawLine(
          Offset(xUnit, yUnit), Offset(xUnit, yUnit + lineWidth), paint);
      yUnit = yUnit + lineWidth + yLinePadding;
    }
    yUnit = 0;
    while (xUnit < size.width) {
      canvas
        ..drawLine(Offset(xUnit, 0), Offset(xUnit + lineWidth, 0), paint)
        ..drawLine(Offset(xUnit, size.height),
            Offset(xUnit + lineWidth, size.height), paint);
      xUnit = xUnit + lineWidth + xLinePadding;
    }

    while (yUnit < size.height) {
      canvas.drawLine(
          Offset(xUnit, yUnit), Offset(xUnit, yUnit + lineWidth), paint);
      yUnit = yUnit + lineWidth + xLinePadding;
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
