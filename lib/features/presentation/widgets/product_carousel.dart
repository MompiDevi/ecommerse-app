import 'package:flutter/material.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'cards/product_card.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onProductTap;
  const ProductCarousel({Key? key, required this.products, required this.onProductTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Related Products',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 160,
                child: ProductCard(
                  product: products[index],
                  onTap: () => onProductTap(products[index]),
                  showHero: false,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
