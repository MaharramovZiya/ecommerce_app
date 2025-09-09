import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../uikit/components/svg_icon.dart';
import '../../../uikit/constants/icons.dart';

class CategoryTab extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryTab({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: AppSizes.spacingS),
            child: GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingM,
                  vertical: AppSizes.paddingS,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.radiusL),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.tertiary,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgIcon(
                      _getCategoryIcon(category),
                      size: 16,
                      color: isSelected ? AppColors.white : AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _translateCategory(category),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isSelected ? AppColors.white : AppColors.primary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _translateCategory(String category) {
    switch (category.toLowerCase()) {
      case 'all items':
        return 'All Items';
      case 'phones':
        return 'Phones';
      case 'dress':
        return 'Dress';
      case 'jeans':
        return 'Jeans';
      case 'shoes':
        return 'Shoes';
      case 'accessory':
        return 'Accessory';

      default:
        return category; // Return original if no translation found
    }
  }

  AppsIcons _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'all items':
        return AppsIcons.category;
      case 'phones':
        return AppsIcons.call;
      case 'dress':
        return AppsIcons.womenDress;
      case 'jeans':
        return AppsIcons.jeans; // Using tshirt icon for jeans
      case 'shoes':
        return AppsIcons.shoes;
      case 'accessory':
        return AppsIcons.magic; // Using shop icon for accessory

      default:
        return AppsIcons.shop;
    }
  }
}
