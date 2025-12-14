import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A sophisticated logo animation for MaryAir featuring an airplane
/// traveling along the brand name with smooth takeoff and landing sequences.
class MaryAirLogoAnimation extends StatefulWidget {
  final VoidCallback? onAnimationComplete;
  final Duration duration;
  final Size size;

  const MaryAirLogoAnimation({
    super.key,
    this.onAnimationComplete,
    this.duration = const Duration(milliseconds: 4500),
    this.size = const Size(500, 180),
  });

  @override
  State<MaryAirLogoAnimation> createState() => _MaryAirLogoAnimationState();
}

class _MaryAirLogoAnimationState extends State<MaryAirLogoAnimation>
    with SingleTickerProviderStateMixin {
  static const _initialDelay = Duration(milliseconds: 300);

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);

    // Multi-stage animation curve for realistic flight physics
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic, // Smooth acceleration and deceleration
    );

    _startAnimationSequence();
  }

  void _startAnimationSequence() {
    Future.delayed(_initialDelay, () {
      if (!mounted) return;

      _controller.forward().then((_) {
        widget.onAnimationComplete?.call();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: widget.size,
          painter: _MaryAirLogoPainter(
            animationValue: _animation.value,
            primaryColor: const Color(0xFF2C3E50), // Dark blue
            accentColor: const Color(0xFFE74C3C), // Red
            trailColor: const Color(0xFF3498DB), // Light blue
          ),
        );
      },
    );
  }
}

class _MaryAirLogoPainter extends CustomPainter {
  final double animationValue;
  final Color primaryColor;
  final Color accentColor;
  final Color trailColor;

  _MaryAirLogoPainter({
    required this.animationValue,
    required this.primaryColor,
    required this.accentColor,
    required this.trailColor,
  });

  static const _textStyle = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w800,
    letterSpacing: 6,
    fontFamily: 'Helvetica',
  );

  @override
  void paint(Canvas canvas, Size size) {
    // Create text painter to measure exact dimensions
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'MARYAIR',
        style: _textStyle.copyWith(color: primaryColor),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final textWidth = textPainter.width;
    final textHeight = textPainter.height;
    final textOffset = Offset(
      (size.width - textWidth) / 2,
      (size.height - textHeight) / 2 + textHeight * 0.85,
    );

    // Draw text background first
    _drawTextBackground(canvas, textOffset, textPainter, size);

    // Calculate precise letter positions
    final letterWidth = textWidth / 7;
    final baselineY = textOffset.dy;

    // Calculate plane trajectory (staying within letter contours)
    final trajectory = _calculateTrajectory(
      textOffset,
      letterWidth,
      baselineY,
      textHeight,
    );

    // Draw filled trail behind the text
    _drawTrailFill(canvas, trajectory, size);

    // Draw text on top
    textPainter.paint(canvas, textOffset);

    // Calculate current plane position and orientation
    final (planePosition, planeAngle) = _calculatePlaneState(
      trajectory,
      animationValue,
      baselineY,
      textHeight,
    );

    // Draw the airplane
    _drawAirplane(canvas, planePosition, planeAngle);

    // Draw subtle glow effect at current position
    _drawPositionGlow(canvas, planePosition);
  }

  List<Offset> _calculateTrajectory(
    Offset textOffset,
    double letterWidth,
    double baselineY,
    double textHeight,
  ) {
    final points = <Offset>[];

    // SVG-style smooth swoosh curve: starts low-left, dips, then rises to top-right
    // Based on: M130,150 C210,95 360,60 520,82 C590,92 730,110 740,115

    // Start point - bottom left (below M)
    points.add(
      Offset(textOffset.dx + letterWidth * 0.15, baselineY + textHeight * 0.30),
    );

    // First curve control - dips down and right
    points.add(
      Offset(textOffset.dx + letterWidth * 1.2, baselineY + textHeight * 0.18),
    );

    // Lowest point of swoosh (under A-R area)
    points.add(
      Offset(textOffset.dx + letterWidth * 2.5, baselineY + textHeight * 0.10),
    );

    // Start rising (under Y)
    points.add(
      Offset(textOffset.dx + letterWidth * 3.8, baselineY + textHeight * 0.08),
    );

    // Continue rise (under A)
    points.add(
      Offset(textOffset.dx + letterWidth * 4.8, baselineY + textHeight * 0.02),
    );

    // Rising more (under I)
    points.add(
      Offset(textOffset.dx + letterWidth * 5.8, baselineY - textHeight * 0.05),
    );

    // Near end, curving up (under R)
    points.add(
      Offset(textOffset.dx + letterWidth * 6.8, baselineY - textHeight * 0.12),
    );

    // Final position - top right (above and right of text)
    points.add(
      Offset(textOffset.dx + letterWidth * 7.4, baselineY - textHeight * 0.18),
    );

    return points;
  }

  void _drawTextBackground(
    Canvas canvas,
    Offset textOffset,
    TextPainter textPainter,
    Size size,
  ) {
    final backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(
        textOffset.dx - 20,
        textOffset.dy - textPainter.height,
        textPainter.width + 40,
        textPainter.height + 20,
      ),
      backgroundPaint,
    );
  }

  void _drawTrailFill(Canvas canvas, List<Offset> trajectory, Size size) {
    if (animationValue == 0) return;

    final progressIndex = (animationValue * (trajectory.length - 1))
        .clamp(0, trajectory.length - 1)
        .toDouble();
    final intSegment = progressIndex.floor();
    final fracSegment = progressIndex - intSegment;

    // Create gradient for trail (prominent swoosh like SVG)
    final gradient = LinearGradient(
      colors: [
        trailColor.withValues(alpha: 0.8),
        trailColor.withValues(alpha: 0.6),
        trailColor.withValues(alpha: 0.3),
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    final trailPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          6.0 // Thicker for more prominent swoosh
      ..strokeCap = StrokeCap.round;

    // Draw smooth curved path (only where plane has traveled)
    final path = Path();
    path.moveTo(trajectory.first.dx, trajectory.first.dy);

    for (int i = 1; i < trajectory.length; i++) {
      if (animationValue * (trajectory.length - 1) < i) break;

      final t = (animationValue * (trajectory.length - 1) - (i - 1)).clamp(
        0.0,
        1.0,
      );
      final point = Offset.lerp(trajectory[i - 1], trajectory[i], t)!;

      if (i == 1) {
        path.lineTo(point.dx, point.dy);
      } else {
        // Smooth Bézier curve through points (like SVG)
        final prev = trajectory[i - 2];
        final control1 = Offset(
          prev.dx + (trajectory[i - 1].dx - prev.dx) * 0.6,
          prev.dy + (trajectory[i - 1].dy - prev.dy) * 0.4,
        );
        final control2 = Offset(
          trajectory[i - 1].dx + (point.dx - trajectory[i - 1].dx) * 0.4,
          trajectory[i - 1].dy + (point.dy - trajectory[i - 1].dy) * 0.6,
        );

        path.cubicTo(
          control1.dx,
          control1.dy,
          control2.dx,
          control2.dy,
          point.dx,
          point.dy,
        );
      }
    }

    canvas.drawPath(path, trailPaint);
  }

  (Offset, double) _calculatePlaneState(
    List<Offset> trajectory,
    double progress,
    double baselineY,
    double textHeight,
  ) {
    final totalSegments = trajectory.length - 1;
    final progressScaled = progress * totalSegments;
    final segment = progressScaled.floor().clamp(0, totalSegments - 1);
    final segmentProgress = progressScaled - segment;

    final start = trajectory[segment];
    final end = trajectory[segment + 1];

    final position = Offset.lerp(start, end, segmentProgress)!;

    // Calculate angle - mostly horizontal with slight upward curve at end
    double angle;
    if (segment < 4) {
      // First half - nearly horizontal with very slight upward tilt
      angle = -math.pi / 32; // ~5.6 degrees up
    } else if (segment < 6) {
      // Middle - slight upward curve
      angle = -math.pi / 20; // ~9 degrees up
    } else if (segment < 7) {
      // Near end - curving up more
      angle = -math.pi / 12; // ~15 degrees up
    } else {
      // Final segment - steeper upward curve
      angle = -math.pi / 8; // ~22.5 degrees up
    }

    return (position, angle);
  }

  void _drawAirplane(Canvas canvas, Offset position, double angle) {
    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate(angle);

    // Draw a more realistic 2D plane silhouette
    final planePaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Main fuselage (elongated body)
    final fuselagePath = Path()
      ..moveTo(-18, 0)
      ..lineTo(18, -1)
      ..lineTo(16, -5)
      ..lineTo(-16, -5)
      ..close();

    canvas.drawPath(fuselagePath, planePaint);
    canvas.drawPath(fuselagePath, outlinePaint);

    // Nose cone
    final nosePath = Path()
      ..moveTo(18, -1)
      ..lineTo(22, -3)
      ..lineTo(18, -4)
      ..close();

    canvas.drawPath(nosePath, planePaint);
    canvas.drawPath(nosePath, outlinePaint);

    // Main wings (swept back)
    final leftWingPath = Path()
      ..moveTo(-2, 0)
      ..lineTo(-8, 12)
      ..lineTo(-2, 10)
      ..lineTo(2, 0)
      ..close();

    final rightWingPath = Path()
      ..moveTo(-2, -5)
      ..lineTo(-8, -16)
      ..lineTo(-2, -14)
      ..lineTo(2, -5)
      ..close();

    canvas.drawPath(leftWingPath, planePaint);
    canvas.drawPath(rightWingPath, planePaint);
    canvas.drawPath(leftWingPath, outlinePaint);
    canvas.drawPath(rightWingPath, outlinePaint);

    // Tail fin (vertical stabilizer)
    final tailFinPath = Path()
      ..moveTo(-16, -5)
      ..lineTo(-20, -12)
      ..lineTo(-14, -12)
      ..lineTo(-14, -5)
      ..close();

    canvas.drawPath(tailFinPath, planePaint);
    canvas.drawPath(tailFinPath, outlinePaint);

    // Horizontal stabilizer
    final horizStabPath = Path()
      ..moveTo(-16, -5)
      ..lineTo(-20, -5)
      ..lineTo(-22, 2)
      ..lineTo(-16, 0)
      ..close();

    canvas.drawPath(horizStabPath, planePaint);
    canvas.drawPath(horizStabPath, outlinePaint);

    // Cockpit windows (multiple)
    final windowPaint = Paint()
      ..color =
          const Color(0xFF1E3A8A) // Dark blue windows
      ..style = PaintingStyle.fill;

    // Front cockpit window
    canvas.drawCircle(const Offset(12, -2.5), 2.0, windowPaint);
    // Passenger windows
    canvas.drawCircle(const Offset(6, -2.5), 1.5, windowPaint);
    canvas.drawCircle(const Offset(0, -2.5), 1.5, windowPaint);
    canvas.drawCircle(const Offset(-6, -2.5), 1.5, windowPaint);

    // Engine under wing
    final enginePaint = Paint()
      ..color = Colors.grey[700]!
      ..style = PaintingStyle.fill;

    canvas.drawOval(const Rect.fromLTWH(-6, 8, 6, 3), enginePaint);
    canvas.drawOval(const Rect.fromLTWH(-6, 8, 6, 3), outlinePaint);

    canvas.restore();
  }

  void _drawPositionGlow(Canvas canvas, Offset position) {
    final glowPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawCircle(position, 10, glowPaint);
  }

  @override
  bool shouldRepaint(_MaryAirLogoPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.trailColor != trailColor;
  }
}
