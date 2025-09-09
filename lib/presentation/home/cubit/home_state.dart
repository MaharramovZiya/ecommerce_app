part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductEntity> products;
  final List<String> categories;

  const HomeLoaded(this.products, this.categories);

  @override
  List<Object?> get props => [products, categories];
}

class HomeFeaturedProductsLoaded extends HomeState {
  final List<ProductEntity> featuredProducts;

  const HomeFeaturedProductsLoaded(this.featuredProducts);

  @override
  List<Object?> get props => [featuredProducts];
}

class HomeCategoriesLoaded extends HomeState {
  final List<String> categories;

  const HomeCategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class HomeSearchResultsLoaded extends HomeState {
  final List<ProductEntity> searchResults;

  const HomeSearchResultsLoaded(this.searchResults);

  @override
  List<Object?> get props => [searchResults];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
