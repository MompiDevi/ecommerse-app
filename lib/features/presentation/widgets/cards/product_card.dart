import 'dart:ui';
import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_image.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final bool showHero;

  const ProductCard({
    Key? key,
    required this.onTap,
    required this.product,
    this.showHero = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ProductImage(
        imageUrl: product.image,
        width: double.infinity,
        height: double.infinity,
        borderRadius: 16,
        fit: BoxFit.cover,
      ),
    );
    if (showHero) {
      imageWidget = Hero(
        tag: 'product-image-${product.id}',
        child: imageWidget,
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.card,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Stack(
          children: [
            imageWidget,
            // Rating Badge
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.grey12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: AppColors.orange, size: 14),
                    SizedBox(width: 2),
                    Text(
                      '4.5',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            // Favorite Icon
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.grey12,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.favorite_border, size: 16),
              ),
            ),
            // Frosted Glass Bottom Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16), top: Radius.circular(16)
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: AppColors.card.withOpacity(0.3),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            color: AppColors.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product.price.toString(),
                          style: TextStyle(
                            color: AppColors.grey87,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
