import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/common/extensions/widget_extensions.dart';
import 'package:flutter_coffee_shop/src/config/styles/styles.dart';

class CounterIconButton extends StatelessWidget {
  const CounterIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        AppDimensions.circle,
      ),
      child: Material(
        color: context.colorsExt.accentColor,
        child: InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            color: context.colorsExt.secondaryColor,
            size: 16,
          ).paddingAll(4),
        ),
      ),
    );
  }
}
