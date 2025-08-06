import 'package:flutter/material.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/core/app_strings.dart';

class ProductDetailsBottom extends StatelessWidget {
  final Product product;
  final int quantity;
  final int selectedColor;
  final int selectedSize;
  final List<Color> colors;
  final List<String> sizes;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<int> onColorChanged;
  final ValueChanged<int> onSizeChanged;

  const ProductDetailsBottom({
    Key? key,
    required this.product,
    required this.quantity,
    required this.selectedColor,
    required this.selectedSize,
    required this.colors,
    required this.sizes,
    required this.onQuantityChanged,
    required this.onColorChanged,
    required this.onSizeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey300),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) onQuantityChanged(quantity - 1);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        quantity.toString().padLeft(2, "0"),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          onQuantityChanged(quantity + 1);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Price
            Text(
              "\$ ${product.price}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            // Colors
            Row(
              children: List.generate(colors.length, (index) {
                return GestureDetector(
                  onTap: () => onColorChanged(index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedColor == index
                            ? AppColors.amber
                            : AppColors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: colors[index],
                      radius: 14,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            // Sizes
            const Text(
              AppStrings.size,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(sizes.length, (index) {
                  final isSelected = selectedSize == index;
                  return GestureDetector(
                    onTap: () => onSizeChanged(index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.amber : AppColors.transparent,
                        border: Border.all(
                          color: isSelected ? AppColors.amber : AppColors.grey300,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        sizes[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: isSelected ? AppColors.card : AppColors.onSecondary,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            // Description
            const Text(
              AppStrings.description,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(product.description),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
