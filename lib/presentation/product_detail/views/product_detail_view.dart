import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/product_detail_cubit.dart';
import '../../../presentation/favorites/cubit/favorites_cubit.dart';
import '../../../presentation/cart/cubit/cart_cubit.dart';
import '../../../routes/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/size_selector.dart';
import '../widgets/color_selector.dart';
import '../widgets/quantity_selector.dart';

class ProductDetailView extends StatefulWidget {
  final String productId;

  const ProductDetailView({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailCubit>().loadProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRouter.home),
        ),
        title: const Text(AppStrings.productDetail),
        actions: [
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, favoritesState) {
              final isFavorite = context.read<FavoritesCubit>().isFavorite(widget.productId);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(widget.productId);
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share product
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductDetailError) {
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
                    onPressed: () => context.read<ProductDetailCubit>().loadProduct(widget.productId),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          } else if (state is ProductDetailLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Images
                  ProductImageCarousel(images: state.product.images),
                  
                  // Product Info
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Text(
                          state.product.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSizes.spacingS),
                        
                        // Rating
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < state.product.rating.floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 20,
                                  color: Colors.amber,
                                );
                              }),
                            ),
                            const SizedBox(width: AppSizes.spacingS),
                            Text(
                              '${state.product.rating.toStringAsFixed(1)} (${state.product.reviewCount} ${AppStrings.reviews})',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spacingM),
                        
                        // Price
                        Row(
                          children: [
                            Text(
                              Helpers.formatCurrency(state.product.price * state.quantity),
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (state.quantity > 1) ...[
                              const SizedBox(width: AppSizes.spacingS),
                              Text(
                                '(${Helpers.formatCurrency(state.product.price)} × ${state.quantity})',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                            if (state.product.isOnSale && state.product.originalPrice > state.product.price) ...[
                              const SizedBox(width: AppSizes.spacingS),
                              Text(
                                Helpers.formatCurrency(state.product.originalPrice * state.quantity),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: AppSizes.spacingL),
                        
                        // Description
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSizes.spacingS),
                        Text(
                          state.product.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSizes.spacingL),
                        
                        // Size Selector
                        if (state.product.sizes.isNotEmpty) ...[
                          Text(
                            AppStrings.chooseSize,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSizes.spacingS),
                          SizeSelector(
                            sizes: state.product.sizes,
                            selectedSize: state.selectedSize,
                            onSizeSelected: (size) {
                              context.read<ProductDetailCubit>().selectSize(size);
                            },
                          ),
                          const SizedBox(height: AppSizes.spacingL),
                        ],
                        
                        // Color Selector
                        if (state.product.colors.isNotEmpty) ...[
                          Text(
                            AppStrings.color,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSizes.spacingS),
                          ColorSelector(
                            colors: state.product.colors,
                            selectedColor: state.selectedColor,
                            onColorSelected: (color) {
                              context.read<ProductDetailCubit>().selectColor(color);
                            },
                          ),
                          const SizedBox(height: AppSizes.spacingL),
                        ],
                        
                        // Quantity Selector
                        Text(
                          AppStrings.quantity,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSizes.spacingS),
                        QuantitySelector(
                          quantity: state.quantity,
                          onQuantityChanged: (quantity) {
                            context.read<ProductDetailCubit>().updateQuantity(quantity);
                          },
                        ),
                        const SizedBox(height: AppSizes.spacingXL),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoaded) {
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
                child: Row(
                  children: [
                    // Add to Cart Button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final cartItem = CartItemEntity(
                            id: '${state.product.id}_${state.selectedSize ?? 'default'}_${state.selectedColor ?? 'default'}',
                            productId: state.product.id,
                            name: state.product.name,
                            price: state.product.price,
                            image: state.product.images.isNotEmpty ? state.product.images.first : '',
                            quantity: state.quantity,
                            size: state.selectedSize ?? '',
                            color: state.selectedColor ?? '',
                          );
                          
                          context.read<CartCubit>().addToCart(cartItem);
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${state.product.name} added to cart'),
                              backgroundColor: Colors.green,
                              action: SnackBarAction(
                                label: 'View Cart',
                                textColor: Colors.white,
                                onPressed: () => context.go(AppRouter.cart),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: Text('${AppStrings.addToCart} | ${Helpers.formatCurrency(state.product.price * state.quantity)}'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingM),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
