import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WizardCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? height;
  final EdgeInsetsGeometry padding;

  const WizardCard({
    super.key,
    required this.child,
    this.onTap,
    this.height,
    this.padding = const EdgeInsets.all(AppTheme.spacingL),
  });

  @override
  Widget build(BuildContext context) {
    const radius = 50.0;
    const borderRadius = BorderRadius.only(
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
    );

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          // Background & Border Painter
          Positioned.fill(
            child: CustomPaint(painter: _WizardBorderPainter(radius: radius)),
          ),
          // Content & Ripple
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              child: Container(
                padding: padding,
                width: double.infinity,
                // height is handled by SizedBox parent or content
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WizardBorderPainter extends CustomPainter {
  final double radius;

  _WizardBorderPainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 2.0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black.withOpacity(0.3);

    // 1. Draw Fill
    final rrect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
      topLeft: Radius.zero,
      bottomRight: Radius.zero,
    );
    canvas.drawRRect(rrect, fillPaint);

    // 2. Draw Borders
    // We need to inset the path by half stroke width to keep it inside/centered?
    // Flutter borders usually draw inside for Container, but CustomPainter draws centered on path.
    // Let's just draw simple paths.

    final pathPurple = Path();
    final pathGold = Path();

    // Purple Path: Left Edge (+ BL Curve) + Top Edge (+ TL Corner)
    // Let's decide corner ownership clearly:
    // Purple: Left Line, Top Line, Bottom-Left Arc.
    // Gold: Right Line, Bottom Line, Top-Right Arc.

    // NOTE: Arc angles. 0 is Right. PI/2 is Down. PI is Left. 3PI/2 (-PI/2) is Up.

    // Purple Path Construction
    // Start at Bottom end of Left Line (start of BL arc) -> (0, H-radius) ??
    // Actually, BL arc is from Angle PI (Left) to Angle PI/2 (Bottom).
    // Let's include BL arc in Purple.
    // Start at Bottom-Left-Bottom (radius, Height).
    // Arc to Bottom-Left-Left (0, Height-radius).
    // Line to Top-Left (0, 0).
    // Line to Top-Right-Start (Width-radius, 0).

    pathPurple.moveTo(radius, size.height);
    pathPurple.arcTo(
      Rect.fromLTWH(0, size.height - 2 * radius, 2 * radius, 2 * radius),
      0.5 * 3.14159, // Start at 90 deg (Bottom)
      0.5 * 3.14159, // Sweep 90 deg (to Left/180)
      false,
    );
    pathPurple.lineTo(0, 0); // Up to TL
    pathPurple.lineTo(size.width - radius, 0); // Right to TR start

    paint.color = AppTheme.maryPurple;
    canvas.drawPath(pathPurple, paint);

    // Gold Path Construction
    // Start at Top-Right-Start (Width-radius, 0).
    // Arc to Top-Right-Right (Width, radius).
    // Line to Bottom-Right (Width, Height).
    // Line to Bottom-Left-Start (radius, Height).

    pathGold.moveTo(size.width - radius, 0);
    pathGold.arcTo(
      Rect.fromLTWH(size.width - 2 * radius, 0, 2 * radius, 2 * radius),
      -0.5 * 3.14159, // Start at -90 deg (Top)
      0.5 * 3.14159, // Sweep 90 deg (to Right/0)
      false,
    );
    pathGold.lineTo(size.width, size.height); // Down to BR
    pathGold.lineTo(radius, size.height); // Left to BL start

    paint.color = AppTheme.maryGold;
    canvas.drawPath(pathGold, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
