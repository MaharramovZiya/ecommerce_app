import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onQuantityChanged;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.tertiary),
        borderRadius: BorderRadius.circular(AppSizes.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Minus Button
          IconButton(
            onPressed: quantity > 1 ? () => onQuantityChanged(quantity - 1) : null,
            icon: const Icon(Icons.remove),
            style: IconButton.styleFrom(
              foregroundColor: quantity > 1 ? AppColors.primary : AppColors.secondary,
              padding: const EdgeInsets.all(4),
              minimumSize: const Size(32, 32),
            ),
          ),
          
          // Quantity Display
          Container(
            width: 40,
            padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingS),
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Plus Button
          IconButton(
            onPressed: () => onQuantityChanged(quantity + 1),
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.all(4),
              minimumSize: const Size(32, 32),
            ),
          ),
        ],
      ),
    );
  }
}
