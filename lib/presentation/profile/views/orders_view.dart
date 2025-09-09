import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/profile_cubit.dart';
import '../../../routes/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    super.initState();
    // TODO: Get current user ID and load orders
    // For now, using a placeholder user ID
    context.read<ProfileCubit>().loadOrders('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.orders),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<ProfileCubit>().loadOrders('user_id'),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          } else if (state is ProfileOrdersLoaded) {
            if (state.orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 80,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No orders yet',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your order history will appear here',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.go(AppRouter.home),
                      child: const Text('Start Shopping'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return _OrderCard(order: order);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final dynamic order; // Using dynamic for now since OrderEntity is not fully implemented

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingM),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #12345', // Placeholder order ID
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingS,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(AppSizes.radiusS),
                  ),
                  child: Text(
                    'Delivered', // Placeholder status
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingS),
            
            // Order Date
            Text(
              'Ordered on ${Helpers.formatDate(DateTime.now())}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: AppSizes.spacingM),
            
            // Order Items (Sample)
            const _OrderItemTile(
              name: 'Modern Light Clothes',
              quantity: 2,
              price: 212.99,
            ),
            const _OrderItemTile(
              name: 'Light Dress Bless',
              quantity: 1,
              price: 162.99,
            ),
            
            const Divider(),
            
            // Order Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  Helpers.formatCurrency(588.97), // Placeholder total
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingM),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Implement reorder
                    },
                    child: const Text('Reorder'),
                  ),
                ),
                const SizedBox(width: AppSizes.spacingS),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement track order
                    },
                    child: const Text('Track Order'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemTile extends StatelessWidget {
  final String name;
  final int quantity;
  final double price;

  const _OrderItemTile({
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingS),
      child: Row(
        children: [
          // Product Image Placeholder
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: const Icon(
              Icons.image,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: AppSizes.spacingM),
          
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Qty: $quantity',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Price
          Text(
            Helpers.formatCurrency(price),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
