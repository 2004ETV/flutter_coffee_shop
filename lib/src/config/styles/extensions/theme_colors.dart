import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/config/styles/styles.dart';

@immutable
class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors._({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundPrimaryColor,
    required this.backgroundSecondaryColor,
    required this.accentColor,
  });

  const ThemeColors.base()
      : primaryColor = Colors.black,
        secondaryColor = Colors.white,
        backgroundPrimaryColor = AppColors.mintCream,
        backgroundSecondaryColor = Colors.white,
        accentColor = AppColors.darkSkyBlue;

  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundPrimaryColor;
  final Color backgroundSecondaryColor;
  final Color accentColor;

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundPrimaryColor,
    Color? backgroundSecondaryColor,
    Color? accentColor,
  }) {
    return ThemeColors._(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundPrimaryColor:
          backgroundPrimaryColor ?? this.backgroundPrimaryColor,
      backgroundSecondaryColor:
          backgroundSecondaryColor ?? this.backgroundSecondaryColor,
      accentColor: accentColor ?? this.accentColor,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    covariant ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors._(
      primaryColor: Color.lerp(
        primaryColor,
        other.primaryColor,
        t,
      )!,
      secondaryColor: Color.lerp(
        secondaryColor,
        other.secondaryColor,
        t,
      )!,
      backgroundPrimaryColor: Color.lerp(
        backgroundPrimaryColor,
        other.backgroundPrimaryColor,
        t,
      )!,
      backgroundSecondaryColor: Color.lerp(
        backgroundSecondaryColor,
        other.backgroundSecondaryColor,
        t,
      )!,
      accentColor: Color.lerp(
        accentColor,
        other.accentColor,
        t,
      )!,
    );
  }
}
