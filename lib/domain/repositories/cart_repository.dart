import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemEntity>>> getCartItems(String userId);
  Future<Either<Failure, CartItemEntity>> addToCart(CartItemEntity item);
  Future<Either<Failure, CartItemEntity>> updateCartItem(String itemId, int quantity);
  Future<Either<Failure, void>> removeFromCart(String itemId);
  Future<Either<Failure, void>> clearCart(String userId);
  Future<Either<Failure, CartItemEntity?>> getCartItemByProductId(String userId, String productId, String size, String color);
}
