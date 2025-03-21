import 'package:flutter/material.dart';

class AppColors {
  // COLORS
  static const grey950 = Color(0xFF030712);
  static const grey900 = Color(0xFF18181B);
  static const grey800 = Color(0xFF27272A);
  static const grey600 = Color(0xFF52525B);
  static const grey500 = Color(0xFF71717A);
  static const grey400 = Color(0xFFA1A1AA);
  static const grey200 = Color(0xFFE5E5E5);
  static const grey50 = Color(0xFFFAFAFA);
  static const primaryColor900 = Color(0xFF21296D);
  static const primaryColor500 = Color(0xFF5A74FA);
  static const primaryColor50 = Color(0xFFEDF4FF);
  static const primaryColor400 = Color(0xFF7999FF);
  static const primaryColor100 = Color(0xFFDEEBFF);
  static const errorColor50 = Color(0xFFFEF2F2);
  static const errorColor100 = Color(0xFFFEE2E2);
  static const errorColor500 = Color(0xFFEF4444);
  static const warningColor50 = Color(0xFFFFFBEB);
  static const warningColor100 = Color(0xFFFEF3C7);
  static const warningColor500 = Color(0xFFF59E0B);
  static const warningColor300 = Color(0xFFFCD34D);
  static const successColor50 = Color(0xFFF0FDF4);
  static const successColor100 = Color(0xFFDCFCE7);
  static const successColor500 = Color(0xFF22C55E);
  static const successColor600 = Color(0xFF16A34A);
  static const successColor700 = Color(0xFF15803D);
  static const secondaryColorBlue = Color(0xFF00B0D5);
  static const secondaryColorBlue2 = Color(0xFF00B0D5);
  static const secondaryColorBlue3 = Color(0xFFE8FBFF);
  static const secondaryColorPink = Color(0xFF9B2589);
  static const greyScaleColor = Color(0xFFE5E5E5);

  // GRADIENTS
  static const blueGradient = LinearGradient(
    colors: [
      secondaryColorBlue,
      Color(0xFF9CEEFF),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const tempGraadient = LinearGradient(
    colors: [
      errorColor500,
      warningColor300,
      successColor500,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
