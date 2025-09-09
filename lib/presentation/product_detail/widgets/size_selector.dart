import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String? selectedSize;
  final Function(String) onSizeSelected;

  const SizeSelector({
    super.key,
    required this.sizes,
    this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.spacingS,
      runSpacing: AppSizes.spacingS,
      children: sizes.map((size) {
        final isSelected = size == selectedSize;
        
        return GestureDetector(
          onTap: () => onSizeSelected(size),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.tertiary,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                size,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected ? AppColors.white : AppColors.primary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
