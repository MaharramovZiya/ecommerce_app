import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/favorites/cubit/favorites_cubit.dart';
import '../../../uikit/components/custom_app_bar.dart';
import '../../../uikit/constants/icons.dart';
import '../../../uikit/components/svg_icon_button.dart';
import '../../../uikit/components/svg_icon.dart';
import '../../../routes/app_router.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../presentation/home/widgets/product_card.dart';
import '../../../domain/entities/favorite_entity.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {

  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorites',
        actions: [
          SvgIconButton(
            icon: AppsIcons.search,
            onTap: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoritesError) {
            return _buildErrorState(context, state.message);
          } else if (state is FavoritesLoaded || state is FavoritesUpdated) {
            final favorites = state is FavoritesLoaded ? state.favorites : (state as FavoritesUpdated).favorites;
            if (favorites.isEmpty) {
              return _buildEmptyState(context);
            }
            return _buildFavoritesList(context, favorites);
          } else if (state is FavoritesCleared) {
            return _buildEmptyState(context);
          }
          
          return _buildEmptyState(context);
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
            AppsIcons.heart,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: AppSizes.spacingL),
          Text(
            'No Favorites Yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spacingS),
          Text(
            'Add products to your favorites to see them here',
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

  Widget _buildFavoritesList(BuildContext context, List<FavoriteEntity> favorites) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: AppSizes.spacingM,
            mainAxisSpacing: AppSizes.spacingM,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final favorite = favorites[index];
            return ProductCard(
              product: favorite.product,
              onTap: () {
                context.go('${AppRouter.productDetail}/${favorite.product.id}');
              },
            );
          },
        ),
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
              context.read<FavoritesCubit>().loadFavorites();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}