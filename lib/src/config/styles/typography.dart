import 'package:flutter/material.dart';

abstract class AppTypography {
  const AppTypography._();

  static const robotoRegular12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: .4,
  );

  static const robotoRegular14 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: .25,
  );

  static const robotoMedium16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: .15,
  );

  static const robotoSemiBold32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );
}
