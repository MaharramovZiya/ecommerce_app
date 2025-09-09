import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/usecases/cart/get_cart_items_usecase.dart';
import '../../../domain/usecases/cart/add_to_cart_usecase.dart';
import '../../../domain/usecases/cart/update_cart_item_usecase.dart';
import '../../../domain/usecases/cart/remove_from_cart_usecase.dart';
import '../../../domain/usecases/cart/clear_cart_usecase.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase _getCartItemsUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final UpdateCartItemUseCase _updateCartItemUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;

  CartCubit({
    required GetCartItemsUseCase getCartItemsUseCase,
    required AddToCartUseCase addToCartUseCase,
    required UpdateCartItemUseCase updateCartItemUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required ClearCartUseCase clearCartUseCase,
  })  : _getCartItemsUseCase = getCartItemsUseCase,
        _addToCartUseCase = addToCartUseCase,
        _updateCartItemUseCase = updateCartItemUseCase,
        _removeFromCartUseCase = removeFromCartUseCase,
        _clearCartUseCase = clearCartUseCase,
        super(CartInitial());

  Future<void> loadCartItems(String userId) async {
    emit(CartLoading());
    
    final result = await _getCartItemsUseCase(GetCartItemsParams(userId: userId));
    
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (cartItems) => emit(CartLoaded(cartItems)),
    );
  }

  Future<void> addToCart(CartItemEntity item) async {
    final result = await _addToCartUseCase(AddToCartParams(item: item));
    
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (addedItem) {
        // Məhsul əlavə edildikdən sonra cart-ı yenidən yüklə
        loadCartItems('00000000-0000-0000-0000-000000000000');
      },
    );
  }

  Future<void> updateCartItem(String itemId, int quantity) async {
    final result = await _updateCartItemUseCase(UpdateCartItemParams(itemId: itemId, quantity: quantity));
    
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (updatedItem) {
        final currentState = state;
        if (currentState is CartLoaded) {
          final updatedItems = currentState.cartItems.map((item) {
            return item.id == itemId ? updatedItem : item;
          }).toList();
          emit(CartLoaded(updatedItems));
        }
      },
    );
  }

  Future<void> removeFromCart(String itemId) async {
    final result = await _removeFromCartUseCase(RemoveFromCartParams(itemId: itemId));
    
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (_) {
        final currentState = state;
        if (currentState is CartLoaded) {
          final updatedItems = currentState.cartItems.where((item) => item.id != itemId).toList();
          emit(CartLoaded(updatedItems));
        }
      },
    );
  }

  Future<void> clearCart(String userId) async {
    final result = await _clearCartUseCase(ClearCartParams(userId: userId));
    
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (_) => emit(CartEmpty()),
    );
  }

  double getTotalPrice() {
    final currentState = state;
    if (currentState is CartLoaded) {
      return currentState.cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    }
    return 0.0;
  }

  int getTotalItems() {
    final currentState = state;
    if (currentState is CartLoaded) {
      return currentState.cartItems.fold(0, (sum, item) => sum + item.quantity);
    }
    return 0;
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'Network error. Please check your connection.';
      case ServerFailure:
        return 'Server error. Please try again later.';
      case DataNotFoundFailure:
        return 'Cart item not found.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
