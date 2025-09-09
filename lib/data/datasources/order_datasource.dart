import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/logger.dart';
import '../models/order_model.dart';

abstract class OrderDataSource {
  Future<List<OrderModel>> getOrders(String userId);
  Future<OrderModel> getOrderById(String orderId);
  Future<OrderModel> createOrder(OrderModel order);
  Future<OrderModel> updateOrderStatus(String orderId, String status);
  Future<void> cancelOrder(String orderId);
}

@injectable
class OrderDataSourceImpl implements OrderDataSource {
  final SupabaseClient _supabaseClient;

  OrderDataSourceImpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<List<OrderModel>> getOrders(String userId) async {
    try {
      AppLogger.info('Fetching orders for user: $userId');
      
      final response = await _supabaseClient
          .from('orders')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final orders = (response as List)
          .map((json) => OrderModel.fromJson(json))
          .toList();

      AppLogger.info('Fetched ${orders.length} orders');
      return orders;
    } catch (e) {
      AppLogger.error('Get orders error: $e');
      throw ServerException(message: 'Failed to fetch orders: ${e.toString()}');
    }
  }

  @override
  Future<OrderModel> getOrderById(String orderId) async {
    try {
      AppLogger.info('Fetching order by id: $orderId');
      
      final response = await _supabaseClient
          .from('orders')
          .select('*')
          .eq('id', orderId)
          .single();

      final order = OrderModel.fromJson(response);
      AppLogger.info('Order fetched successfully: ${order.id}');
      
      return order;
    } catch (e) {
      AppLogger.error('Get order by id error: $e');
      throw DataNotFoundException(message: 'Order not found: ${e.toString()}');
    }
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      AppLogger.info('Creating order for user: ${order.userId}');
      
      final response = await _supabaseClient
          .from('orders')
          .insert(order.toJson())
          .select()
          .single();

      final createdOrder = OrderModel.fromJson(response);
      AppLogger.info('Order created successfully: ${createdOrder.id}');
      
      return createdOrder;
    } catch (e) {
      AppLogger.error('Create order error: $e');
      throw ServerException(message: 'Failed to create order: ${e.toString()}');
    }
  }

  @override
  Future<OrderModel> updateOrderStatus(String orderId, String status) async {
    try {
      AppLogger.info('Updating order status: $orderId to $status');
      
      final response = await _supabaseClient
          .from('orders')
          .update({
            'status': status,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId)
          .select()
          .single();

      final updatedOrder = OrderModel.fromJson(response);
      AppLogger.info('Order status updated successfully');
      
      return updatedOrder;
    } catch (e) {
      AppLogger.error('Update order status error: $e');
      throw ServerException(message: 'Failed to update order status: ${e.toString()}');
    }
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    try {
      AppLogger.info('Cancelling order: $orderId');
      
      await _supabaseClient
          .from('orders')
          .update({
            'status': 'cancelled',
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId);

      AppLogger.info('Order cancelled successfully');
    } catch (e) {
      AppLogger.error('Cancel order error: $e');
      throw ServerException(message: 'Failed to cancel order: ${e.toString()}');
    }
  }
}
