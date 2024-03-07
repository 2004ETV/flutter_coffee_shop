import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/config/styles/styles.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/counter_icon_button.dart';

class CounterBlock extends StatelessWidget {
  const CounterBlock({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.count,
  });

  final int count;
  final GestureTapCallback onIncrement;
  final GestureTapCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CounterIconButton(
          icon: Icons.remove_rounded,
          onTap: onDecrement,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: context.colorsExt.accentColor,
              borderRadius: BorderRadius.circular(
                AppDimensions.circle,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: AppTypography.robotoRegular12.copyWith(
                color: context.colorsExt.secondaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        CounterIconButton(
          icon: Icons.add_rounded,
          onTap: onIncrement,
        ),
      ],
    );
  }
}
