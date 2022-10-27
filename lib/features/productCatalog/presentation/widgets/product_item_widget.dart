import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../domain/entities/product_item.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductItem product;
  final Function()? onPressed;

  const ProductItemWidget(
      {super.key, required this.product, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return _ProductItemCard(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductItemImage(child: Image.network(product.imageUrl)),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            '${product.product.name} ${product.brand}',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'R\$ ${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          _ProductItemButton(onPressed: onPressed)
        ],
      ),
    ));
  }
}

class _ProductItemCard extends StatelessWidget {
  final Widget? child;
  const _ProductItemCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 180,
        height: 310,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
          child: child,
        ));
  }
}

class _ProductItemImage extends StatelessWidget {
  final Widget? child;
  const _ProductItemImage({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: child,
      ),
    );
  }
}

class _ProductItemButton extends StatelessWidget {
  final Function()? onPressed;
  const _ProductItemButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColors.secondaryColor),
            onPressed: onPressed,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(
              'Add ao Carrinho',
              style: TextStyle(color: Colors.white, fontSize: 12),
            )));
  }
}
