import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerse_app/features/presentation/screens/payment_successful_screen.dart';
import 'package:ecommerse_app/features/presentation/widgets/cart_item_tile.dart';
import 'package:ecommerse_app/features/presentation/widgets/cart_summary_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
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
                            return CartItemTile(product: product, quantity: quantity);
                          },
                        ),
                      ),
                      CartSummarySection(
                        subtotal: subtotal,
                        deliveryFee: deliveryFee,
                        total: total,
                        onCheckout: () {
                          Navigator.push(
                            context,
                          MaterialPageRoute(
                          builder: (context) =>  PaymentSuccessScreen(amount: total,currency: 'usd',merchantDisplayName: 'Landmark',),
                        ));
                        },
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
}
