import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/home_cubit.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../../routes/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import 'package:ecommerce_apps/uikit/components/custom_app_bar.dart';
import 'package:ecommerce_apps/uikit/widgets/search_filter.dart';

import 'package:ecommerce_apps/uikit/components/svg_icon_button.dart';
import 'package:ecommerce_apps/uikit/constants/icons.dart';

import '../widgets/product_card.dart';
import '../widgets/category_tab.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  String _selectedCategory = AppStrings.allItems;
  String _selectedSortBy = 'name';
  bool _isOnSale = false;
  bool _isFeatured = false;
  bool _hasLoadedOnce = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Əvvəlcə categories yüklə, sonra products
    context.read<HomeCubit>().loadCategories();
    context.read<HomeCubit>().loadProducts();
    _hasLoadedOnce = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Səhifəyə hər dəfə gələndə məhsulları yenidən yüklə (yalnız bir dəfə)
    if (_hasLoadedOnce) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _loadProductsWithCurrentFilters();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin üçün lazımdır
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            String userName = 'User';
            if (state is AuthAuthenticated) {
              userName = state.user.name;
            }
            
            return CustomAppBar(
              isHomeStyle: true,
              userName: userName,
              actions: [
                SvgIconButton(
                  icon: AppsIcons.basket,
                  onTap: () => context.go(AppRouter.cart),
                ),
              ],
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: SearchBarWithFilter(
              controller: TextEditingController(),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  context.read<HomeCubit>().searchProducts(query);
                } else {
                  // Reset to show all products when search is cleared
                  if (_selectedCategory == AppStrings.allItems) {
                    context.read<HomeCubit>().loadProducts();
                  } else {
                    context.read<HomeCubit>().loadProducts(category: _selectedCategory);
                  }
                }
              },
              onFilterTap: () {
                _showFilterBottomSheet(context);
              },
            ),
          ),
          // Category Tabs
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeCategoriesLoaded || state is HomeLoaded) {
                final categories = state is HomeCategoriesLoaded 
                    ? state.categories 
                    : (state as HomeLoaded).categories;
                    
                return CategoryTab(
                  categories: [AppStrings.allItems, ...categories],
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                    if (category == AppStrings.allItems) {
                      context.read<HomeCubit>().loadProducts();
                    } else {
                      // Use category directly for API call
                      final originalCategory = category;
                      context.read<HomeCubit>().loadProducts(category: originalCategory);
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // Products Grid
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeError) {
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
                          onPressed: () {
                            if (_selectedCategory == AppStrings.allItems) {
                              context.read<HomeCubit>().loadProducts();
                            } else {
                              context.read<HomeCubit>().loadProducts(category: _selectedCategory);
                            }
                          },
                          child: const Text(AppStrings.retry),
                        ),
                      ],
                    ),
                  );
                } else if (state is HomeLoaded || state is HomeSearchResultsLoaded) {
                  final products = state is HomeLoaded 
                      ? state.products 
                      : (state as HomeSearchResultsLoaded).searchResults;
                  
                  if (products.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                                                  Text(
                          AppStrings.noProductsFound,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.tryAdjustingYourSearchOrFilters,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(AppSizes.paddingM),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: AppSizes.spacingM,
                      mainAxisSpacing: AppSizes.spacingM,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => context.go(
                          AppRouter.productDetail,
                          extra: product.id,
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),

    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedSortBy = 'name';
                        _isOnSale = false;
                        _isFeatured = false;
                      });
                      Navigator.pop(context);
                      _applyFilters();
                    },
                    child: const Text('Clear All'),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Filter options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sort By
                    const Text(
                      'Sort By',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildFilterChip('Name', 'name', _selectedSortBy),
                        _buildFilterChip('Price Low to High', 'price_asc', _selectedSortBy),
                        _buildFilterChip('Price High to Low', 'price_desc', _selectedSortBy),
                        _buildFilterChip('Newest', 'createdAt', _selectedSortBy),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Special Offers
                    const Text(
                      'Special Offers',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: _isOnSale,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            setState(() {
                              _isOnSale = value ?? false;
                            });
                            // Yalnız visual olaraq dəyişir, tətbiq etmir
                          },
                        ),
                        const Text('On Sale'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isFeatured,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            setState(() {
                              _isFeatured = value ?? false;
                            });
                            // Yalnız visual olaraq dəyişir, tətbiq etmir
                          },
                        ),
                        const Text('Featured'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Apply button
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _applyFilters();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, String selectedValue) {
    final isSelected = selectedValue == value;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.primary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedSortBy = value;
        });
        // Yalnız visual olaraq dəyişir, tətbiq etmir
      },
      backgroundColor: Colors.white,
      selectedColor: AppColors.primary,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.primary.withOpacity(0.3),
        width: 1,
      ),
    );
  }

  void _loadProductsWithCurrentFilters() {
    // Cari filterlərlə məhsulları yüklə
    context.read<HomeCubit>().loadProducts(
      category: _selectedCategory == AppStrings.allItems ? null : _selectedCategory,
      sortBy: _selectedSortBy,
      isOnSale: _isOnSale ? true : null,
      isFeatured: _isFeatured ? true : null,
    );
  }

  void _applyFilters() {
    _loadProductsWithCurrentFilters();
  }
}
