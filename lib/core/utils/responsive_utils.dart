import 'package:flutter/material.dart';

/// Centralized responsive utility for consistent sizing across all screens.
/// Uses MediaQuery to adapt padding, font sizes, icon sizes, and spacing
/// to different screen dimensions, eliminating overflow/out-of-pixel issues.
class Responsive {
  Responsive._();

  /// Screen breakpoints (logical pixels width)
  static const double _smallBreakpoint = 360;
  static const double _mediumBreakpoint = 410;

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < _smallBreakpoint;

  static bool isMediumScreen(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= _smallBreakpoint && w < _mediumBreakpoint;
  }

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= _mediumBreakpoint;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Returns a value scaled proportionally to the screen width.
  /// Base reference width is 390 (standard modern phone).
  static double scaleWidth(BuildContext context, double value) {
    return value * MediaQuery.of(context).size.width / 390;
  }

  /// Returns a value scaled proportionally to the screen height.
  /// Base reference height is 844 (standard modern phone).
  static double scaleHeight(BuildContext context, double value) {
    return value * MediaQuery.of(context).size.height / 844;
  }

  /// Responsive horizontal padding — smaller on narrow screens.
  static double horizontalPadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < _smallBreakpoint) return 14;
    if (w < _mediumBreakpoint) return 18;
    return 20;
  }

  /// Responsive general padding for cards and sections.
  static double padding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < _smallBreakpoint) return 14;
    if (w < _mediumBreakpoint) return 16;
    return 20;
  }

  /// Responsive font scale factor (0.85–1.0 based on width).
  static double fontScale(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < _smallBreakpoint) return 0.85;
    if (w < _mediumBreakpoint) return 0.92;
    return 1.0;
  }

  /// Responsive icon size.
  static double iconSize(BuildContext context, double baseSize) {
    return baseSize * fontScale(context);
  }
}
