// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerse_app/core/app_strings.dart';
import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:ecommerse_app/features/domain/entities/cart_product.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/presentation/screens/cart_screen.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_details_header.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_carousel.dart';
import 'package:ecommerse_app/features/presentation/blocs/product/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_details_bottom.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;
  int selectedColor = 0;
  int selectedSize = 1;

  final List<Color> colors = [
    AppColors.product1,
    AppColors.product2,
    AppColors.product3,
    AppColors.product4,
  ];
  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product details header with back and cart navigation
              ProductDetailsHeader(
                product: widget.product,
                onBack: () => Navigator.pop(context),
                onCart: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                ),
              ),
              // Product details section for selecting options and adding to cart
              ProductDetailsBottom(
                product: widget.product,
                quantity: quantity,
                selectedColor: selectedColor,
                selectedSize: selectedSize,
                colors: colors,
                sizes: sizes,
                onQuantityChanged: (val) => setState(() => quantity = val),
                onColorChanged: (val) => setState(() => selectedColor = val),
                onSizeChanged: (val) => setState(() => selectedSize = val),
              ),
              // Related products carousel
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    // Exclude the current product from related
                    final related = state.products.where((p) => p.id != widget.product.id).take(8).toList();
                    return ProductCarousel(
                      products: related,
                      onProductTap: (product) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(product: product),
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppStrings.itemAddedToCart)),
                );
              } else if (state is CartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: AppButton(
              label: AppStrings.addToCart,
              onPressed: () {
                context.read<CartBloc>().add(AddToCartEvent(
                      cart: Cart(
                        date: DateTime.now(),
                        userId: 1,
                        products: [CartProduct(productID: widget.product.id, quantity: quantity)],
                      ),userId: 1
                    ));
              },
              backgroundColor: AppColors.amber,
              foregroundColor: AppColors.onSecondary,
              borderRadius: 28,
              height: 50,
            ),
          ),
        ),
      ),
    );
  }
}

// Product details screen showing product info, options, and related products.
// Handles quantity, color, and size selection, and allows adding to cart.
// Shows related products carousel and feedback on cart actions.
