import 'package:flutter/material.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_image.dart';
import 'package:ecommerse_app/features/presentation/widgets/quantity_selector.dart';
import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/core/app_strings.dart';

class CartItemTile extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartItemTile({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(product.id),
      background: Container(
        color: AppColors.redAccent,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: AppColors.onPrimary),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context.read<CartBloc>().add(RemoveFromCart(product.id));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ProductImage(
                imageUrl: product.image,
                width: 80,
                height: 80,
                borderRadius: 12,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text('${AppStrings.qty} $quantity'),
                  const SizedBox(height: 8),
                  QuantitySelector(
                    quantity: quantity,
                    onDecrement: () {
                      context.read<CartBloc>().add(UpdateCartItemQuantity(
                        productId: product.id,
                        newQuantity: quantity - 1,
                        userId: 1,
                      ));
                    },
                    onIncrement: () {
                      context.read<CartBloc>().add(UpdateCartItemQuantity(
                        productId: product.id,
                        newQuantity: quantity + 1,
                        userId: 1,
                      ));
                    },
                    min: 1,
                  ),
                ],
              ),
            ),
            Text(
              '₹${(product.price * quantity).toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
