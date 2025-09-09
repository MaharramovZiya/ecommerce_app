import 'package:flutter/material.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';

class PriceSummary extends StatelessWidget {
  final List<CartItemEntity> cartItems;
  final VoidCallback onCheckout;

  const PriceSummary({
    super.key,
    required this.cartItems,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final subtotal = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    final shippingFee = 0.0; // Free shipping
    final discount = 0.0; // No discount
    final total = subtotal + shippingFee - discount;
    final totalItems = cartItems.fold(0, (sum, item) => sum + item.quantity);

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.spacingM),
            
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppStrings.subtotal} ($totalItems items)',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  Helpers.formatCurrency(subtotal),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingS),
            
            // Shipping Fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.shippingFee,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  shippingFee == 0 ? 'Free' : Helpers.formatCurrency(shippingFee),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: shippingFee == 0 ? Colors.green : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingS),
            
            // Discount
            if (discount > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.discount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '-${Helpers.formatCurrency(discount)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            
            const Divider(),
            
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.total,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  Helpers.formatCurrency(total),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingL),
            
            // Checkout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingM),
                ),
                child: Text('${AppStrings.checkout} - ${Helpers.formatCurrency(total)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
