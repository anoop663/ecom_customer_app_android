import 'package:flutter/material.dart';

import '../values/colors.dart';

class CircleSliderThumb implements RangeSliderThumbShape {
  const CircleSliderThumb({
    this.radius = 15.0,
    this.ringColor = AppColors.textColor2,
  });

  final double radius;

  final Color ringColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = true,
    bool isEnabled = true,
    bool isOnTop = true,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = AppColors.textColor2
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, borderPaint);
  }
}
