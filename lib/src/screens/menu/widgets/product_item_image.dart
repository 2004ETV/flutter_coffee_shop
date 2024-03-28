import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_coffee_shop/src/common/assets/assets.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/config/styles/styles.dart';

class ProductItemImage extends StatelessWidget {
  const ProductItemImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.mediumSmall),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) {
          return Container(
            height: 100,
            decoration: BoxDecoration(
              color: context.colorsExt.backgroundPrimaryColor,
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesPlaceholder),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
