import 'package:flutter/material.dart';
import 'package:ecommerse_app/core/app_strings.dart';
import 'package:ecommerse_app/features/presentation/widgets/app_button.dart';
import 'package:ecommerse_app/features/presentation/widgets/summary_row.dart';
import 'package:ecommerse_app/core/theme/app_colors.dart';

class CartSummarySection extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double total;
  final VoidCallback onCheckout;

  const CartSummarySection({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          SummaryRow(label: AppStrings.subTotal, value: '₹${subtotal.toStringAsFixed(2)}'),
          SummaryRow(label: AppStrings.deliveryFee, value: '₹${deliveryFee.toStringAsFixed(2)}'),
          const Divider(),
          SummaryRow(label: AppStrings.totalCost, value: '₹${total.toStringAsFixed(2)}', isTotal: true),
          const SizedBox(height: 16),
          AppButton(
            label: AppStrings.checkout,
            onPressed: onCheckout,
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            borderRadius: 12,
          )
        ],
      ),
    );
  }
}
