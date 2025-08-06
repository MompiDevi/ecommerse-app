import 'package:flutter/material.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';

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
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context.read<CartBloc>().add(RemoveFromCart(product.id));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
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
                  Text('Qty: $quantity'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _quantityButton(context, Icons.remove, () {
                        context.read<CartBloc>().add(UpdateCartItemQuantity(
                          productId: product.id,
                          newQuantity: quantity - 1,
                          userId: 1,
                        ));
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(quantity.toString().padLeft(2, '0')),
                      ),
                      _quantityButton(context, Icons.add, () {
                        context.read<CartBloc>().add(UpdateCartItemQuantity(
                          productId: product.id,
                          newQuantity: quantity + 1,
                          userId: 1,
                        ));
                      }),
                    ],
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

  Widget _quantityButton(BuildContext context, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 16),
      ),
    );
  }
}
