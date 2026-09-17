import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0A0F172A),
      blurRadius: 20,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x050F172A),
      blurRadius: 6,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> elevated = [
    BoxShadow(
      color: Color(0x140F172A),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> glowingGreen = [
    BoxShadow(
      color: Color(0x3315803D),
      blurRadius: 20,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  // Soft glow for accent elements
  static const List<BoxShadow> softGreenGlow = [
    BoxShadow(
      color: Color(0x2222C55E),
      blurRadius: 24,
      offset: Offset(0, 4),
      spreadRadius: 2,
    ),
  ];

  static const List<BoxShadow> softBlueGlow = [
    BoxShadow(
      color: Color(0x220284C7),
      blurRadius: 24,
      offset: Offset(0, 4),
      spreadRadius: 2,
    ),
  ];

  static const List<BoxShadow> softOrangeGlow = [
    BoxShadow(
      color: Color(0x22F97316),
      blurRadius: 24,
      offset: Offset(0, 4),
      spreadRadius: 2,
    ),
  ];

  // Bottom navigation shadow
  static const List<BoxShadow> bottomNav = [
    BoxShadow(
      color: Color(0x100F172A),
      blurRadius: 20,
      offset: Offset(0, -4),
      spreadRadius: 0,
    ),
  ];

  // Floating card shadow
  static const List<BoxShadow> floating = [
    BoxShadow(
      color: Color(0x1A0F172A),
      blurRadius: 32,
      offset: Offset(0, 12),
      spreadRadius: -2,
    ),
  ];
}
