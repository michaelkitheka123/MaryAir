import 'package:flutter/material.dart';
import 'dart:ui';

class DashedContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Color color;
  final double dashLength;
  final double gapLength;
  final BorderRadius borderRadius;

  const DashedContainer({
    super.key,
    required this.child,
    this.strokeWidth = 1.0,
    this.color = Colors.black,
    this.dashLength = 5.0,
    this.gapLength = 3.0,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        strokeWidth: strokeWidth,
        color: color,
        dashLength: dashLength,
        gapLength: gapLength,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double dashLength;
  final double gapLength;
  final BorderRadius borderRadius;

  _DashedBorderPainter({
    required this.strokeWidth,
    required this.color,
    required this.dashLength,
    required this.gapLength,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rect = borderRadius.toRRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    final Path path = Path()..addRRect(rect);

    // Create dashed path
    final Path dashedPath = Path();
    double distance = 0.0;

    for (final PathMetric metric in path.computeMetrics()) {
      while (distance < metric.length) {
        dashedPath.addPath(
          metric.extractPath(distance, distance + dashLength),
          Offset.zero,
        );
        distance += dashLength + gapLength;
      }
      distance = 0.0;
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.gapLength != gapLength ||
        oldDelegate.borderRadius != borderRadius;
  }
}
