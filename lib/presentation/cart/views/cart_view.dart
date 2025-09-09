import 'package:ecommerce_apps/uikit/components/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../uikit/components/custom_app_bar.dart';
import '../../../uikit/constants/icons.dart';
import '../../../uikit/components/svg_icon_button.dart';
import '../../../routes/app_router.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../cubit/cart_cubit.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    // Cart məlumatlarını yüklə
    print('CartView: Loading cart items...');
    context.read<CartCubit>().loadCartItems('00000000-0000-0000-0000-000000000000'); // Test user ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Shopping Cart',
        actions: [
          SvgIconButton(
            icon: AppsIcons.search,
            onTap: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          print('CartView: Current state: ${state.runtimeType}');
          
          if (state is CartLoading) {
            print('CartView: Loading state');
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            print('CartView: Loaded state with ${state.cartItems.length} items');
            if (state.cartItems.isEmpty) {
              return _buildEmptyState(context);
            }
            
            return _buildCartContent(context, state);
          } else if (state is CartError) {
            print('CartView: Error state: ${state.message}');
            return _buildErrorState(context, state.message);
          } else if (state is CartInitial) {
            print('CartView: Initial state');
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          print('CartView: Unknown state');
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.cartItems.isNotEmpty) {
            return _buildCheckoutBar(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            AppsIcons.basket,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: AppSizes.spacingL),
          Text(
            'Your Cart is Empty',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spacingS),
          Text(
            'Add some products to your cart to see them here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacingXL),
          ElevatedButton(
            onPressed: () => context.go(AppRouter.home),
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartLoaded state) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = state.cartItems[index];
              return _buildCartItem(context, cartItem);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartItemEntity cartItem) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingM),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
                child: Image.network(
                  cartItem.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image);
                  },
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spacingM),
            
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${cartItem.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            // Quantity Controls
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>().updateCartItem(
                          cartItem.id,
                          cartItem.quantity - 1,
                        );
                      },
                      icon: const Icon(Icons.remove),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.background,
                        minimumSize: const Size(32, 32),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${cartItem.quantity}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>().updateCartItem(
                          cartItem.id,
                          cartItem.quantity + 1,
                        );
                      },
                      icon: const Icon(Icons.add),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        minimumSize: const Size(32, 32),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                IconButton(
                  onPressed: () {
                    context.read<CartCubit>().removeFromCart(cartItem.id);
                  },
                  icon: const Icon(Icons.delete_outline),
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutBar(BuildContext context, CartLoaded state) {
    final totalPrice = state.cartItems.fold<double>(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.spacingM),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Navigate to checkout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Checkout functionality coming soon!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                ),
              ),
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: AppSizes.spacingL),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spacingS),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacingXL),
          ElevatedButton(
            onPressed: () {
              // TODO: Get actual user ID from AuthCubit
              context.read<CartCubit>().loadCartItems('user_id');
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}