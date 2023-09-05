import 'package:flutter/material.dart';

class LineData {
  final Color color;
  final int strokeWidth;
  final List<Offset> points;

  const LineData({
    required this.color,
    required this.strokeWidth,
    required this.points,
  });
}
