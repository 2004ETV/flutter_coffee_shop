import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/config/styles/styles.dart';

@immutable
class ThemeTypography extends ThemeExtension<ThemeTypography> {
  const ThemeTypography._({
    required this.robotoRegular12,
    required this.robotoRegular14,
    required this.robotoMedium16,
    required this.robotoBold24,
    required this.robotoSemiBold32,
  });

  ThemeTypography.base({Color color = Colors.black})
      : robotoRegular12 = AppTypography.robotoRegular12.copyWith(
          color: color,
        ),
        robotoRegular14 = AppTypography.robotoRegular14.copyWith(
          color: color,
        ),
        robotoMedium16 = AppTypography.robotoMedium16.copyWith(
          color: color,
        ),
        robotoBold24 = AppTypography.robotoSemiBold32.copyWith(
          color: color,
        ),
        robotoSemiBold32 = AppTypography.robotoSemiBold32.copyWith(
          color: color,
        );

  static ThemeTypography of(BuildContext context) =>
      Theme.of(context).extension<ThemeTypography>()!;

  final TextStyle robotoRegular12;
  final TextStyle robotoRegular14;
  final TextStyle robotoMedium16;
  final TextStyle robotoBold24;
  final TextStyle robotoSemiBold32;

  @override
  ThemeExtension<ThemeTypography> copyWith({
    TextStyle? robotoRegular12,
    TextStyle? robotoRegular14,
    TextStyle? robotoMedium16,
    TextStyle? robotoBold24,
    TextStyle? robotoSemiBold32,
  }) {
    return ThemeTypography._(
      robotoRegular12: robotoRegular12 ?? this.robotoRegular12,
      robotoRegular14: robotoRegular14 ?? this.robotoRegular14,
      robotoMedium16: robotoRegular12 ?? this.robotoMedium16,
      robotoBold24: robotoBold24 ?? this.robotoBold24,
      robotoSemiBold32: robotoRegular12 ?? this.robotoSemiBold32,
    );
  }

  @override
  ThemeExtension<ThemeTypography> lerp(
    covariant ThemeExtension<ThemeTypography>? other,
    double t,
  ) {
    if (other is! ThemeTypography) {
      return this;
    }

    return ThemeTypography._(
      robotoRegular12: TextStyle.lerp(
        robotoRegular12,
        other.robotoRegular12,
        t,
      )!,
      robotoRegular14: TextStyle.lerp(
        robotoRegular14,
        other.robotoRegular14,
        t,
      )!,
      robotoMedium16: TextStyle.lerp(
        robotoMedium16,
        other.robotoMedium16,
        t,
      )!,
      robotoBold24: TextStyle.lerp(
        robotoBold24,
        other.robotoBold24,
        t,
      )!,
      robotoSemiBold32: TextStyle.lerp(
        robotoSemiBold32,
        other.robotoSemiBold32,
        t,
      )!,
    );
  }
}
