import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int min;
  final int max;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.min = 1,
    this.max = 99,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _quantityButton(Icons.remove, onDecrement, enabled: quantity > min),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(quantity.toString().padLeft(2, '0'), style: const TextStyle(fontSize: 16)),
        ),
        _quantityButton(Icons.add, onIncrement, enabled: quantity < max),
      ],
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap, {bool enabled = true}) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: enabled ? AppColors.grey : AppColors.greyShade300,
        ),),
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 16, color: enabled ? AppColors.onSecondary : AppColors.grey),
      ),
    );
  }
}
