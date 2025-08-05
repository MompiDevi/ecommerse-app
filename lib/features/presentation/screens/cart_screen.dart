import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerse_app/features/presentation/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Cart'),),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, productsState) {
          if (productsState is ProductLoaded) {
            return BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                if (cartState is CartLoaded) {
                  final cartItems = cartState.cart?.products.map((item) {
                    final product = productsState.products.firstWhere(
                      (p) => p.id == item.productID,
                    );
                    return {
                      'product': product,
                      'quantity': item.quantity,
                    };
                  }).where((entry) => entry['product'] != null).toList();

                  final subtotal = (cartItems ?? []).fold(0.0, (sum, item) => sum + ((item['product'] as Product).price * (item['quantity'] as int)));
                  const deliveryFee = 45.0;
                  final total = subtotal + deliveryFee;

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: cartItems?.length ?? 0,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final Product product = cartItems?[index]['product'] as Product;
                            final int quantity = cartItems?[index]['quantity'] as int;

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
                                          Text('Qty: ${quantity}'),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              _quantityButton(Icons.remove, () {
                                                context.read<CartBloc>().add(UpdateCartItemQuantity(
                                                  productId: product.id,
                                                  newQuantity: quantity - 1,
                                                  userId: 1
                                                ));
                                              }),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                                child: Text(quantity.toString().padLeft(2, '0')),
                                              ),
                                              _quantityButton(Icons.add, () {
                                                context.read<CartBloc>().add(UpdateCartItemQuantity(
                                                  productId: product.id,
                                                  newQuantity: quantity + 1,
                                                  userId: 1
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
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            _summaryRow('Sub-total', subtotal),
                            _summaryRow('Delivery Fee', deliveryFee),
                            const Divider(),
                            _summaryRow('Total Cost', total, isTotal: true),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => CheckoutScreen(),
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text('Checkout'),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (cartState is CartLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('Something went wrong with your cart.'));
                }
              },
            );
          } else if (productsState is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Unable to load products.'));
          }
        },
      ),
    );
  }

  Widget _summaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
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
