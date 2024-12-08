import 'dart:math';

import 'package:flutter/material.dart';

class ColorsManager {
  static const Color mainPurple = Color(0xFF5F33E1);
  static const Color disbleadPurple = Color(0xFF9A92AF);
  static const Color secondaryLightPurple = Color(0xFFEDE8FF);
  static const Color backgroundLightColor = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFE0E0E0);
  static const Color darkPurple = Color(0xFF24252C);
  static const Color grayPurple = Color(0xFF6E6A7C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grayInputBackground = Color(0xFFF2F0F5);
  static const Color grayInputHintText = Color(0xFF9A9A9A);
  static const Color grayButtonBorder = Color(0xFFD8DADC);

  // Colors for Sticker Pack Card
  static const Color royalPurple = Color(0xFF7E57C2); // Rich purple
  static const Color emeraldGreen = Color(0xFF2E7D32); // Deep forest green
  static const Color coralRed = Color(0xFFE57373); // Vibrant coral
  static const Color oceanBlue = Color(0xFF1976D2); // Deep ocean blue
  static const Color sunsetOrange = Color(0xFFFF7043); // Warm orange
  static const Color tealGreen = Color(0xFF00796B); // Rich teal
  static const Color berryPink = Color(0xFFEC407A); // Deep pink
  static const Color indigoBlue = Color(0xFF3949AB); // Rich indigo
  static const Color amber = Color(0xFFFFB300); // Golden amber
  static const Color crimsonRed = Color(0xFFD32F2F); // Deep red

  static const List<Color> cardColors = [
    mainPurple,
    royalPurple,
    emeraldGreen,
    coralRed,
    oceanBlue,
    sunsetOrange,
    tealGreen,
    berryPink,
    indigoBlue,
    amber,
    crimsonRed,
  ];

  // Random color generator
  static final Random _random = Random();

  static Color getRandomColor() {
    return cardColors[_random.nextInt(cardColors.length)];
  }

  // Optional: Get random color with custom opacity
  static Color getRandomColorWithOpacity(double opacity) {
    return cardColors[_random.nextInt(cardColors.length)].withOpacity(opacity);
  }
}
