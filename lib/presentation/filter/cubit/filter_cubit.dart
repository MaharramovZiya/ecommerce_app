import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'filter_state.dart';

@injectable
class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  // Filter options
  String? _selectedCategory;
  String? _selectedSortBy;
  double? _minPrice;
  double? _maxPrice;
  bool? _isOnSale;
  bool? _isFeatured;
  List<String> _selectedBrands = [];
  List<String> _selectedSizes = [];
  List<String> _selectedColors = [];

  // Getters
  String? get selectedCategory => _selectedCategory;
  String? get selectedSortBy => _selectedSortBy;
  double? get minPrice => _minPrice;
  double? get maxPrice => _maxPrice;
  bool? get isOnSale => _isOnSale;
  bool? get isFeatured => _isFeatured;
  List<String> get selectedBrands => _selectedBrands;
  List<String> get selectedSizes => _selectedSizes;
  List<String> get selectedColors => _selectedColors;

  bool get hasActiveFilters => 
      _selectedCategory != null ||
      _selectedSortBy != null ||
      _minPrice != null ||
      _maxPrice != null ||
      _isOnSale != null ||
      _isFeatured != null ||
      _selectedBrands.isNotEmpty ||
      _selectedSizes.isNotEmpty ||
      _selectedColors.isNotEmpty;

  void setCategory(String? category) {
    _selectedCategory = category;
    emit(FilterUpdated(_getFilterOptions()));
  }

  void setSortBy(String? sortBy) {
    _selectedSortBy = sortBy;
    emit(FilterUpdated(_getFilterOptions()));
  }

  void setPriceRange(double? minPrice, double? maxPrice) {
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    emit(FilterUpdated(_getFilterOptions()));
  }

  void setOnSale(bool? isOnSale) {
    _isOnSale = isOnSale;
    emit(FilterUpdated(_getFilterOptions()));
  }

  void setFeatured(bool? isFeatured) {
    _isFeatured = isFeatured;
    emit(FilterUpdated(_getFilterOptions()));
  }

  void toggleBrand(String brand) {
    if (_selectedBrands.contains(brand)) {
      _selectedBrands.remove(brand);
    } else {
      _selectedBrands.add(brand);
    }
    emit(FilterUpdated(_getFilterOptions()));
  }

  void toggleSize(String size) {
    if (_selectedSizes.contains(size)) {
      _selectedSizes.remove(size);
    } else {
      _selectedSizes.add(size);
    }
    emit(FilterUpdated(_getFilterOptions()));
  }

  void toggleColor(String color) {
    if (_selectedColors.contains(color)) {
      _selectedColors.remove(color);
    } else {
      _selectedColors.add(color);
    }
    emit(FilterUpdated(_getFilterOptions()));
  }

  void clearAllFilters() {
    _selectedCategory = null;
    _selectedSortBy = null;
    _minPrice = null;
    _maxPrice = null;
    _isOnSale = null;
    _isFeatured = null;
    _selectedBrands.clear();
    _selectedSizes.clear();
    _selectedColors.clear();
    emit(FilterCleared());
  }

  void clearCategory() {
    _selectedCategory = null;
    emit(FilterUpdated(_getFilterOptions()));
  }

  void clearPriceRange() {
    _minPrice = null;
    _maxPrice = null;
    emit(FilterUpdated(_getFilterOptions()));
  }

  void clearBrands() {
    _selectedBrands.clear();
    emit(FilterUpdated(_getFilterOptions()));
  }

  void clearSizes() {
    _selectedSizes.clear();
    emit(FilterUpdated(_getFilterOptions()));
  }

  void clearColors() {
    _selectedColors.clear();
    emit(FilterUpdated(_getFilterOptions()));
  }

  Map<String, dynamic> _getFilterOptions() {
    return {
      'category': _selectedCategory,
      'sortBy': _selectedSortBy,
      'minPrice': _minPrice,
      'maxPrice': _maxPrice,
      'isOnSale': _isOnSale,
      'isFeatured': _isFeatured,
      'brands': _selectedBrands,
      'sizes': _selectedSizes,
      'colors': _selectedColors,
    };
  }

  Map<String, dynamic> getFilterParams() {
    final params = <String, dynamic>{};
    
    if (_selectedCategory != null) params['category'] = _selectedCategory;
    if (_selectedSortBy != null) params['sortBy'] = _selectedSortBy;
    if (_minPrice != null) params['minPrice'] = _minPrice;
    if (_maxPrice != null) params['maxPrice'] = _maxPrice;
    if (_isOnSale != null) params['isOnSale'] = _isOnSale;
    if (_isFeatured != null) params['isFeatured'] = _isFeatured;
    if (_selectedBrands.isNotEmpty) params['brands'] = _selectedBrands;
    if (_selectedSizes.isNotEmpty) params['sizes'] = _selectedSizes;
    if (_selectedColors.isNotEmpty) params['colors'] = _selectedColors;
    
    return params;
  }
}
