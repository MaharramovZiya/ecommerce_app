import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/product/get_product_by_id_usecase.dart';

part 'product_detail_state.dart';

@injectable
class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductByIdUseCase _getProductByIdUseCase;

  ProductDetailCubit({
    required GetProductByIdUseCase getProductByIdUseCase,
  }) : _getProductByIdUseCase = getProductByIdUseCase,
       super(ProductDetailInitial());

  Future<void> loadProduct(String productId) async {
    emit(ProductDetailLoading());
    
    final result = await _getProductByIdUseCase(GetProductByIdParams(id: productId));
    
    result.fold(
      (failure) => emit(ProductDetailError(_mapFailureToMessage(failure))),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }

  void selectSize(String size) {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      emit(ProductDetailLoaded(currentState.product, selectedSize: size));
    }
  }

  void selectColor(String color) {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      emit(ProductDetailLoaded(currentState.product, selectedColor: color));
    }
  }

  void updateQuantity(int quantity) {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      emit(ProductDetailLoaded(currentState.product, quantity: quantity));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'Network error. Please check your connection.';
      case ServerFailure:
        return 'Server error. Please try again later.';
      case DataNotFoundFailure:
        return 'Product not found.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
