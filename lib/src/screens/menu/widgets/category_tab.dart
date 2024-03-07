import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/common/extensions/widget_extensions.dart';
import 'package:flutter_coffee_shop/src/config/styles/styles.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key,
    required this.tabIndex,
    required this.selectedTabIndex,
    required this.category,
    required this.onTap,
  });

  final int tabIndex;
  final int selectedTabIndex;
  final String category;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        AppDimensions.circle,
      ),
      child: Material(
        color: tabIndex == selectedTabIndex
            ? context.colorsExt.accentColor
            : context.colorsExt.backgroundSecondaryColor,
        child: InkWell(
          onTap: onTap,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              category,
              style: context.textExt.robotoRegular14.copyWith(
                color: tabIndex == selectedTabIndex
                    ? context.colorsExt.secondaryColor
                    : context.colorsExt.primaryColor,
              ),
            ).paddingAll(8),
          ),
        ),
      ),
    );
    ;
  }
}
