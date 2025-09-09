import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/logger.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_datasource.dart';
import '../models/cart_item_model.dart';

@injectable
class CartRepositoryImpl implements CartRepository {
  final CartDataSource _cartDataSource;

  CartRepositoryImpl({required CartDataSource cartDataSource})
      : _cartDataSource = cartDataSource;

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCartItems(String userId) async {
    try {
      AppLogger.info('Repository: Getting cart items for user: $userId');
      final cartItems = await _cartDataSource.getCartItems(userId);
      return Right(cartItems.map((item) => item.toEntity()).toList());
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, CartItemEntity>> addToCart(CartItemEntity item) async {
    try {
      AppLogger.info('Repository: Adding item to cart: ${item.name}');
      final cartItemModel = CartItemModel.fromEntity(item);
      final addedItem = await _cartDataSource.addToCart(cartItemModel);
      return Right(addedItem.toEntity());
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, CartItemEntity>> updateCartItem(String itemId, int quantity) async {
    try {
      AppLogger.info('Repository: Updating cart item: $itemId with quantity: $quantity');
      final updatedItem = await _cartDataSource.updateCartItem(itemId, quantity);
      return Right(updatedItem.toEntity());
    } on DataNotFoundException catch (e) {
      AppLogger.error('Repository: Data not found: ${e.message}');
      return Left(DataNotFoundFailure(message: e.message));
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(String itemId) async {
    try {
      AppLogger.info('Repository: Removing cart item: $itemId');
      await _cartDataSource.removeFromCart(itemId);
      return const Right(null);
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart(String userId) async {
    try {
      AppLogger.info('Repository: Clearing cart for user: $userId');
      await _cartDataSource.clearCart(userId);
      return const Right(null);
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, CartItemEntity?>> getCartItemByProductId(String userId, String productId, String size, String color) async {
    try {
      AppLogger.info('Repository: Getting cart item by product id: $productId');
      final cartItem = await _cartDataSource.getCartItemByProductId(userId, productId, size, color);
      return Right(cartItem?.toEntity());
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }
}
