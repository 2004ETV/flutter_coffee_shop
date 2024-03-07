import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/common/assets/assets.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/common/extensions/widget_extensions.dart';
import 'package:flutter_coffee_shop/src/common/widgets/primary_button.dart';
import 'package:flutter_coffee_shop/src/config/styles/styles.dart';
import 'package:flutter_coffee_shop/src/repo/menu/models.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/counter_block.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.model,
    required this.onTap,
    required this.onIncrement,
    required this.onDecrement,
    required this.onPressed,
    required this.count,
  });

  final CategoryItemModel model;
  final GestureTapCallback onTap;
  final ValueChanged<String> onIncrement;
  final ValueChanged<String> onDecrement;
  final ValueChanged<String> onPressed;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      symbol: context.tr.currencySymbol,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        AppDimensions.mediumSmall,
      ),
      child: Material(
        color: context.colorsExt.backgroundSecondaryColor,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              if (model.image == null)
                Image.asset(Assets.imagesPlaceholder)
              else
                Image.asset(
                  model.image!,
                  height: 100,
                ),
              const Gap(8),
              Text(
                model.name,
                overflow: TextOverflow.ellipsis,
                style: context.textExt.robotoMedium16,
                maxLines: 1,
              ),
              const Spacer(),
              if (count != null && count! != 0)
                CounterBlock(
                  onIncrement: () => onIncrement(model.id),
                  onDecrement: () => onDecrement(model.id),
                  count: count!,
                )
              else
                PrimaryButton(
                  onPressed: () => onPressed(model.id),
                  child: Text(
                    currencyFormatter.format(model.price),
                  ),
                ),
            ],
          ).paddingSymmetric(
            vertical: 16,
            horizontal: 32,
          ),
        ),
      ),
    );
  }
}
