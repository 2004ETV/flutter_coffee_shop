import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/config/styles/extensions/extensions.dart';
import 'package:flutter_coffee_shop/src/config/styles/styles.dart';

abstract class AppThemes {
  const AppThemes._();

  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.mintCream,
    extensions: [
      const ThemeColors.base(),
      ThemeTypography.base(),
    ],
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          AppTypography.robotoRegular12,
        ),
        backgroundColor: MaterialStatePropertyAll(AppColors.darkSkyBlue),
        foregroundColor: MaterialStatePropertyAll(Colors.white),
        elevation: MaterialStatePropertyAll(0),
        minimumSize: MaterialStatePropertyAll(Size.fromHeight(0)),
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
  );
}
