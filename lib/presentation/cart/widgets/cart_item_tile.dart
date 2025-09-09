import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import 'quantity_selector.dart';

class CartItemTile extends StatelessWidget {
  final CartItemEntity cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingM),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
              child: CachedNetworkImage(
                imageUrl: cartItem.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.background,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.background,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spacingM),
            
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    cartItem.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.spacingS),
                  
                  // Size and Color
                  Row(
                    children: [
                      if (cartItem.size.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingS,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                          ),
                          child: Text(
                            'Size: ${cartItem.size}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(width: AppSizes.spacingS),
                      ],
                      if (cartItem.color.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingS,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                          ),
                          child: Text(
                            'Color: ${cartItem.color}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacingS),
                  
                  // Price
                  Text(
                    Helpers.formatCurrency(cartItem.price),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Quantity and Actions
            Column(
              children: [
                // Quantity Selector
                QuantitySelector(
                  quantity: cartItem.quantity,
                  onQuantityChanged: onQuantityChanged,
                ),
                const SizedBox(height: AppSizes.spacingS),
                
                // Remove Button
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  tooltip: 'Remove item',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
