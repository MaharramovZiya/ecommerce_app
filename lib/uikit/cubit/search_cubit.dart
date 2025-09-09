import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/product/search_products_usecase.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;
  
  String _currentQuery = '';
  List<ProductEntity> _searchResults = [];
  bool _isSearching = false;

  SearchCubit({
    required SearchProductsUseCase searchProductsUseCase,
  })  : _searchProductsUseCase = searchProductsUseCase,
        super(SearchInitial());

  String get currentQuery => _currentQuery;
  List<ProductEntity> get searchResults => _searchResults;
  bool get isSearching => _isSearching;

  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      _currentQuery = '';
      _searchResults = [];
      _isSearching = false;
      emit(SearchInitial());
      return;
    }

    _currentQuery = query.trim();
    _isSearching = true;
    emit(SearchLoading());

    final result = await _searchProductsUseCase(SearchProductsParams(query: _currentQuery));
    
    result.fold(
      (failure) {
        _isSearching = false;
        emit(SearchError(_mapFailureToMessage(failure)));
      },
      (products) {
        _searchResults = products;
        _isSearching = false;
        emit(SearchLoaded(products));
      },
    );
  }

  void clearSearch() {
    _currentQuery = '';
    _searchResults = [];
    _isSearching = false;
    emit(SearchInitial());
  }

  void updateQuery(String query) {
    _currentQuery = query;
    emit(SearchQueryUpdated(query));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'Network error. Please check your connection.';
      case ServerFailure:
        return 'Server error. Please try again later.';
      case DataNotFoundFailure:
        return 'No products found for your search.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
