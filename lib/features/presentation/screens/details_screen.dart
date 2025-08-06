// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:ecommerse_app/features/domain/entities/cart_product.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/presentation/screens/cart_screen.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_details_header.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_details_bottom.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
