import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/logger.dart';
import '../models/cart_item_model.dart';

abstract class CartDataSource {
  Future<List<CartItemModel>> getCartItems(String userId);
  Future<CartItemModel> addToCart(CartItemModel item);
  Future<CartItemModel> updateCartItem(String itemId, int quantity);
  Future<void> removeFromCart(String itemId);
  Future<void> clearCart(String userId);
  Future<CartItemModel?> getCartItemByProductId(String userId, String productId, String size, String color);
}

@injectable
class CartDataSourceImpl implements CartDataSource {
  final SupabaseClient _supabaseClient;

  CartDataSourceImpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<List<CartItemModel>> getCartItems(String userId) async {
    try {
      AppLogger.info('Fetching cart items for user: $userId');
      
      final response = await _supabaseClient
          .from('cart_items')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final cartItems = (response as List)
          .map((json) {
            // Null safety üçün json-u yoxla
            if (json == null) return null;
            return CartItemModel.fromJson(json as Map<String, dynamic>);
          })
          .where((item) => item != null)
          .cast<CartItemModel>()
          .toList();

      AppLogger.info('Fetched ${cartItems.length} cart items');
      return cartItems;
    } catch (e) {
      AppLogger.error('Get cart items error: $e');
      throw ServerException(message: 'Failed to fetch cart items: ${e.toString()}');
    }
  }

  @override
  Future<CartItemModel> addToCart(CartItemModel item) async {
    try {
      AppLogger.info('Adding item to cart: ${item.name}');
      
      // Check if item already exists in cart
      final existingItem = await getCartItemByProductId(
        '00000000-0000-0000-0000-000000000000', // Test user ID
        item.productId,
        item.size,
        item.color,
      );

      if (existingItem != null) {
        // Update quantity if item exists
        return await updateCartItem(existingItem.id, existingItem.quantity + item.quantity);
      }

      // Create item data
      final itemData = {
        'user_id': '00000000-0000-0000-0000-000000000000', // Test user ID
        'product_id': item.productId,
        'name': item.name,
        'price': item.price,
        'image': item.image,
        'quantity': item.quantity,
        'size': item.size,
        'color': item.color,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Add new item to cart
      final response = await _supabaseClient
          .from('cart_items')
          .insert(itemData)
          .select()
          .single();

      final cartItem = CartItemModel.fromJson(response);
      AppLogger.info('Item added to cart successfully');
      
      return cartItem;
    } catch (e) {
      AppLogger.error('Add to cart error: $e');
      throw ServerException(message: 'Failed to add item to cart: ${e.toString()}');
    }
  }

  @override
  Future<CartItemModel> updateCartItem(String itemId, int quantity) async {
    try {
      AppLogger.info('Updating cart item: $itemId with quantity: $quantity');
      
      if (quantity <= 0) {
        await removeFromCart(itemId);
        throw const DataNotFoundException(message: 'Item removed from cart');
      }

      final response = await _supabaseClient
          .from('cart_items')
          .update({'quantity': quantity, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', itemId)
          .select()
          .single();

      final cartItem = CartItemModel.fromJson(response);
      AppLogger.info('Cart item updated successfully');
      
      return cartItem;
    } catch (e) {
      AppLogger.error('Update cart item error: $e');
      throw ServerException(message: 'Failed to update cart item: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    try {
      AppLogger.info('Removing cart item: $itemId');
      
      await _supabaseClient
          .from('cart_items')
          .delete()
          .eq('id', itemId);

      AppLogger.info('Cart item removed successfully');
    } catch (e) {
      AppLogger.error('Remove from cart error: $e');
      throw ServerException(message: 'Failed to remove item from cart: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      AppLogger.info('Clearing cart for user: $userId');
      
      await _supabaseClient
          .from('cart_items')
          .delete()
          .eq('user_id', userId);

      AppLogger.info('Cart cleared successfully');
    } catch (e) {
      AppLogger.error('Clear cart error: $e');
      throw ServerException(message: 'Failed to clear cart: ${e.toString()}');
    }
  }

  @override
  Future<CartItemModel?> getCartItemByProductId(String userId, String productId, String size, String color) async {
    try {
      AppLogger.info('Getting cart item by product id: $productId');
      
      final response = await _supabaseClient
          .from('cart_items')
          .select('*')
          .eq('user_id', userId)
          .eq('product_id', productId)
          .eq('size', size)
          .eq('color', color)
          .maybeSingle();

      if (response == null) {
        return null;
      }

      return CartItemModel.fromJson(response);
    } catch (e) {
      AppLogger.error('Get cart item by product id error: $e');
      throw ServerException(message: 'Failed to get cart item: ${e.toString()}');
    }
  }
}
