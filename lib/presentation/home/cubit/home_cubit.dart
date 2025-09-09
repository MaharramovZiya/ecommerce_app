import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/product/get_products_usecase.dart';
import '../../../domain/usecases/product/get_featured_products_usecase.dart';
import '../../../domain/usecases/product/get_categories_usecase.dart';
import '../../../domain/usecases/product/search_products_usecase.dart';
import '../../../core/usecases/usecase.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetFeaturedProductsUseCase _getFeaturedProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final SearchProductsUseCase _searchProductsUseCase;
  
  List<String> _categories = [];

  HomeCubit({
    required GetProductsUseCase getProductsUseCase,
    required GetFeaturedProductsUseCase getFeaturedProductsUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required SearchProductsUseCase searchProductsUseCase,
  })  : _getProductsUseCase = getProductsUseCase,
        _getFeaturedProductsUseCase = getFeaturedProductsUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        _searchProductsUseCase = searchProductsUseCase,
        super(HomeInitial());

  Future<void> loadProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    String? sortBy,
    bool? isFeatured,
    bool? isOnSale,
  }) async {
    emit(HomeLoading());
    
    final result = await _getProductsUseCase(GetProductsParams(
      page: page,
      limit: limit,
      category: category,
      search: search,
      sortBy: sortBy,
      isFeatured: isFeatured,
      isOnSale: isOnSale,
    ));
    
    result.fold(
      (failure) => emit(HomeError(_mapFailureToMessage(failure))),
      (products) => emit(HomeLoaded(products, _categories)),
    );
  }

  Future<void> loadFeaturedProducts() async {
    emit(HomeLoading());
    
    final result = await _getFeaturedProductsUseCase(const NoParams());
    
    result.fold(
      (failure) => emit(HomeError(_mapFailureToMessage(failure))),
      (products) => emit(HomeFeaturedProductsLoaded(products)),
    );
  }

  Future<void> loadCategories() async {
    final result = await _getCategoriesUseCase(const NoParams());
    
    result.fold(
      (failure) => emit(HomeError(_mapFailureToMessage(failure))),
      (categories) {
        _categories = categories;
        emit(HomeCategoriesLoaded(categories));
      },
    );
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(HomeInitial());
      return;
    }

    emit(HomeLoading());
    
    final result = await _searchProductsUseCase(SearchProductsParams(query: query));
    
    result.fold(
      (failure) => emit(HomeError(_mapFailureToMessage(failure))),
      (products) => emit(HomeSearchResultsLoaded(products)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'Network error. Please check your connection.';
      case ServerFailure:
        return 'Server error. Please try again later.';
      case DataNotFoundFailure:
        return 'No products found.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
