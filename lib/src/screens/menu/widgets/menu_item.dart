import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/product_domain.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/common/extensions/widget_extensions.dart';
import 'package:flutter_coffee_shop/src/common/widgets/primary_button.dart';
import 'package:flutter_coffee_shop/src/config/styles/styles.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/counter_block.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/product_item_image.dart';
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

  final ProductDomain model;
  final GestureTapCallback onTap;
  final ValueChanged<ProductDomain> onIncrement;
  final ValueChanged<ProductDomain> onDecrement;
  final ValueChanged<ProductDomain> onPressed;
  final int count;

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Intl.getCurrentLocale();

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
              ProductItemImage(
                imageUrl: model.imageUrl,
              ),
              const Gap(8),
              Text(
                model.name,
                overflow: TextOverflow.ellipsis,
                style: context.textExt.robotoMedium16,
                maxLines: 1,
              ),
              const Spacer(),
              if (count != 0)
                CounterBlock(
                  onIncrement: () => onIncrement(model),
                  onDecrement: () => onDecrement(model),
                  count: count,
                )
              else
                PrimaryButton(
                  onPressed: () => onPressed(model),
                  child: Text(
                    context.tr.amountWithSymbol(
                      double.parse(
                        currentLanguage == 'ru_RU'
                            ? model.prices[0].price
                            : model.prices[1].price,
                      ),
                    ),
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
