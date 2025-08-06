import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/core/app_strings.dart';
import 'package:ecommerse_app/features/presentation/widgets/app_icon_button.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_image.dart';
import 'package:ecommerse_app/features/presentation/widgets/cart_icon_count.dart';
import 'package:flutter/material.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';

class ProductDetailsHeader extends StatelessWidget {
  final Product product;
  final VoidCallback onBack;
  final VoidCallback onCart;

  const ProductDetailsHeader({
    super.key,
    required this.product,
    required this.onBack,
    required this.onCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:16,bottom: 8, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIconButton(icon: Icons.arrow_back, onPressed: onBack),
              const Text(
                AppStrings.details,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const CartIconCount()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Stack(
            children: [
              Hero(
                tag: 'product-image-${product.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ProductImage(
                    imageUrl: product.image,
                    width: double.infinity,
                    height: 300,
                    borderRadius: 12,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: AppColors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        AppStrings.rating45,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
