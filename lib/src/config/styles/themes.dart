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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.darkSkyBlue,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.mediumSmall,
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      modalBackgroundColor: Colors.white,
      modalElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.mediumSmall),
        ),
      ),
      showDragHandle: true,
      dragHandleColor: AppColors.lightSilver,
      dragHandleSize: Size(48, 4),
    ),
  );
}
