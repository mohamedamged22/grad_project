import 'package:flutter/material.dart';

/// Responsive utility based on design size of 375x812 (iPhone 13 mini)
class SizeConfig {
  static double _screenWidth = 375;
  static double _screenHeight = 812;

  static const double designWidth = 375;
  static const double designHeight = 812;

  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    _screenWidth = size.width;
    _screenHeight = size.height;
  }

  static double get sw => _screenWidth / designWidth;
  static double get sh => _screenHeight / designHeight;
  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
}

extension SizeExtension on num {
  /// Width-based scaling
  double get w => toDouble() * SizeConfig.sw;

  /// Height-based scaling
  double get h => toDouble() * SizeConfig.sh;

  /// Font size scaling (based on width)
  double get sp => toDouble() * SizeConfig.sw;

  /// Radius scaling (based on width)
  double get r => toDouble() * SizeConfig.sw;
}
