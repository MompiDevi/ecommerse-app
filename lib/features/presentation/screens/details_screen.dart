// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/features/presentation/screens/cart_screen.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_details_header.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_details_bottom.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_carousel.dart';
import 'package:ecommerse_app/features/presentation/blocs/product/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetailsHeader(
                product: widget.product,
                onBack: () => Navigator.pop(context),
                onCart: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                ),
              ),
              ProductDetailsBottom(product: widget.product),
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
    );
  }
}
