import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/product_domain.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/product_item_image.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.model,
  });

  final ProductDomain model;

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Intl.getCurrentLocale();

    return Row(
      children: [
        SizedBox(
          width: 55,
          height: 55,
          child: ProductItemImage(imageUrl: model.imageUrl),
        ),
        const Gap(10),
        Text(
          model.name,
        ),
        const Spacer(),
        Text(
          context.tr.amountWithSymbol(
            double.parse(
              currentLanguage == 'ru_RU'
                  ? model.prices[0].price
                  : model.prices[1].price,
            ),
          ),
          style: context.textExt.robotoMedium16,
        ),
      ],
    );
  }
}
