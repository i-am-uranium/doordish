import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primaryColor = Color(0xFF41DC93);
  static const Color primaryColorLight = Color(0xFFE9FFEA);
  static const Color white = Colors.white;
  static const Color navigationBackgroundColor = Color(0xFF41DC93);
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color lightGrey = Color(0xFFEAEAEA);
  static const Color checkoutContainer = Color(0xFFFCFCFC);
  static final Color divider = const Color(0xFF979797).withOpacity(.2);
  static const Color secondaryText = Color(0xFF9F9F9F);
  static const Color dropTargetFill = Color(0xFFFBFFFD);
  static const Color closeButton = Color(0xFFA9A9A9);
  static const Color paymentCard = Color(0xFFFFFAF2);
  static const Color textFormField = Color(0xFFFCFCFC);
  static const Color error = Colors.red;
  static const Color filterChipInActiveBackground = Color(0xFFFCFCFC);

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }

  static Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100, '');
    final f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }

  static Color brighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100, '');
    final p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round());
  }
}
