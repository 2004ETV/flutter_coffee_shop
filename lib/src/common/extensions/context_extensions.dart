import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/config/styles/extensions/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);

  ThemeColors get colorsExt => Theme.of(this).extension<ThemeColors>()!;

  ThemeTypography get textExt => Theme.of(this).extension<ThemeTypography>()!;

  Size get mediaQuerySize => MediaQuery.of(this).size;

  double get height => mediaQuerySize.height;

  double get width => mediaQuerySize.width;

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode => theme.brightness == Brightness.dark;

  Color? get iconColor => theme.iconTheme.color;

  TextTheme get textTheme => Theme.of(this).textTheme;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;

  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;
}
