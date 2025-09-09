import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class ColorSelector extends StatelessWidget {
  final List<String> colors;
  final String? selectedColor;
  final Function(String) onColorSelected;

  const ColorSelector({
    super.key,
    required this.colors,
    this.selectedColor,
    required this.onColorSelected,
  });

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'brown':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.spacingS,
      runSpacing: AppSizes.spacingS,
      children: colors.map((color) {
        final isSelected = color == selectedColor;
        final colorValue = _getColorFromString(color);
        
        return GestureDetector(
          onTap: () => onColorSelected(color),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorValue,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.tertiary,
                width: isSelected ? 3 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }
}
