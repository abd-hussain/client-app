import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundColor {
  final List<Color> _colorList = const [
    Color(0xFF253334),
    Color(0xFF0F8644),
    Color(0xFF7ADBAE),
    Color(0xFF011833),
    Color(0xFF1A7F72),
    Color(0xFF80C7FF),
    Color(0xFFFFDF99),
    Color(0xFF3124C8),
    Color(0xFF2B2B2B),
    Color(0xFF1A9373),
  ];

  final _random = Random();

  Color getRandomColor() {
    return _colorList[_random.nextInt(_colorList.length)];
  }
}
