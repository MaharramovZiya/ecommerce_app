part of 'product_detail_cubit.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductEntity product;
  final String? selectedSize;
  final String? selectedColor;
  final int quantity;

  const ProductDetailLoaded(
    this.product, {
    this.selectedSize,
    this.selectedColor,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [product, selectedSize, selectedColor, quantity];

  ProductDetailLoaded copyWith({
    ProductEntity? product,
    String? selectedSize,
    String? selectedColor,
    int? quantity,
  }) {
    return ProductDetailLoaded(
      product ?? this.product,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      quantity: quantity ?? this.quantity,
    );
  }
}

class ProductDetailError extends ProductDetailState {
  final String message;

  const ProductDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
