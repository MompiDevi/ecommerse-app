import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:ecommerse_app/features/domain/entities/cart_product.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/presentation/widgets/app_button.dart';
import 'package:ecommerse_app/core/theme/app_colors.dart';

class ProductDetailsBottom extends StatefulWidget {
  final Product product;
  const ProductDetailsBottom({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsBottom> createState() => _ProductDetailsBottomState();
}

class _ProductDetailsBottomState extends State<ProductDetailsBottom> {
  int quantity = 1;
  int selectedColor = 0;
  int selectedSize = 1;
  bool showFullDescription = false;

  final List<Color> colors = [
    AppColors.product1,
    AppColors.product2,
    AppColors.product3,
    AppColors.product4,
  ];

  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];

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
                    widget.product.title,
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
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        quantity.toString().padLeft(2, "0"),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
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
              "Rs. ${widget.product.price}",
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
                  onTap: () {
                    setState(() {
                      selectedColor = index;
                    });
                  },
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
              "Size",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(sizes.length, (index) {
                  final isSelected = selectedSize == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = index;
                      });
                    },
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
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(widget.product.description),
            const SizedBox(height: 16),
            // Buttons
            SizedBox(
              width: double.infinity,
              child: BlocListener<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is CartLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item added to cart!')),
                    );
                  } else if (state is CartError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: AppButton(
                  label: "Add to Cart",
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
          ],
        ),
      ),
    );
  }
}
