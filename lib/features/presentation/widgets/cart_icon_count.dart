import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/presentation/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIconCount extends StatefulWidget {
  const CartIconCount({super.key});

  @override
  State<CartIconCount> createState() => _CartIconCountState();
}

class _CartIconCountState extends State<CartIconCount> {
  int _lastCount = 0;
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int itemCount = 0;
              if (state is CartLoaded) {
                itemCount = state.cart?.products.length ?? 0;
              } else if (state is CartError && state.previousCart != null) {
                itemCount = state.previousCart!.products.length;
              }
              if (_lastCount != itemCount) {
                _animate = true;
                Future.delayed(const Duration(milliseconds: 200), () {
                  if (mounted) setState(() => _animate = false);
                });
                _lastCount = itemCount;
              }
              return AnimatedScale(
                scale: _animate ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.shopping_bag_outlined),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(),
                          ));
                    },
                  ),
                ),
              );
            },
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                // Show loader over the cart icon
                return const Positioned(
                  top: 8,
                  right: 8,
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              int itemCount = 0;
              if (state is CartLoaded) {
                itemCount = state.cart?.products.length ?? 0;
              } else if (state is CartError && state.previousCart != null) {
                itemCount = state.previousCart!.products.length;
              }
              return itemCount > 0
                  ? Positioned(
                      top: 6,
                      right: 0,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                        child: Container(
                          key: ValueKey(itemCount),
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.amber,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$itemCount',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
