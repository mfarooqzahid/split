import 'dart:math';

import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/widgets.dart';

class AvatarGenerator {
  static final List<int> _backgroundColors = [
    0xFFff6b6b, 0xFF4ecdc4, 0xFF45b7d1, 0xFF96ceb4, 0xFFfeca57,
    0xFFff9ff3, 0xFFa55eea, 0xFFfd79a8, 0xFF00b894, 0xFFfdcb6e,
    0xFF6c5ce7, 0xFFfd7272, 0xFF00cec9, 0xFFa29bfe, 0xFFffc107,
  ];

  static Avatar generate({DiceBearSprite sprite = DiceBearSprite.avataaars}) {
    final random = Random();
    return DiceBearBuilder.withRandomSeed(
      radius: 50,
      backgroundColor: Color(_backgroundColors[random.nextInt(_backgroundColors.length)]),
      sprite: sprite,
    ).build();
  }
}
