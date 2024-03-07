import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/common/extensions/widget_extensions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child.paddingSymmetric(
        horizontal: 8,
        vertical: 4,
      ),
    );
  }
}
