library rolling_bottom_bar;

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'constants.dart';

/// Class to generate the moving ball
class RollingPainter extends CustomPainter {
  RollingPainter({
    required this.x,
    this.barGradient,
    this.circleGradient,
  });

  /// Double value to indicate the position to move the ball
  final double? x;

  /// Color for the toolbar
  final ui.Gradient? barGradient;
  final ui.Gradient? circleGradient;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCircle(canvas);
    _drawBar(canvas, size);
  }

  @override
  bool shouldRepaint(RollingPainter oldDelegate) {
    return x != oldDelegate.x;
  }

  void _drawBar(Canvas canvas, Size size) {
    const left = kMargin;
    final right = size.width - kMargin;
    const top = kMargin;
    const bottom = top + kHeight;

    final path = Path()
      ..moveTo(left + kTopRadius, top)
      ..lineTo(x! - kTopRadius + kBottomRadius, top)
      ..relativeArcToPoint(
        const Offset((kCircleRadius + kCircleMargin) * 2, 0.0),
        radius: const Radius.circular(kCircleRadius + kCircleMargin),
        clockwise: false,
      )
      ..lineTo(right - kTopRadius, top)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..lineTo(right, bottom - kBottomRadius)
      ..relativeArcToPoint(
        const Offset(-kBottomRadius, kBottomRadius),
        radius: const Radius.circular(kBottomRadius),
      )
      ..lineTo(left + kBottomRadius, bottom)
      ..relativeArcToPoint(
        const Offset(-kBottomRadius, -kBottomRadius),
        radius: const Radius.circular(kBottomRadius),
      )
      ..lineTo(left, top + kTopRadius)
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(kTopRadius),
      );
    canvas.drawPath(path, Paint()..shader = barGradient);
    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke);
  }

  /// Function used to draw the circular indicator
  void _drawCircle(Canvas canvas) {
    final path = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(
            x! + kCircleMargin + kCircleRadius,
            kMargin + kCircleMargin - kCircleMargin,
          ),
          radius: kCircleRadius,
        ),
        0,
        kPi * 2,
      );
    canvas.drawPath(path, Paint()..shader = circleGradient);
  }
}
