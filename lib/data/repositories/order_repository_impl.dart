import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/logger.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_datasource.dart';
import '../models/order_model.dart';

@injectable
class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource _orderDataSource;

  OrderRepositoryImpl({required OrderDataSource orderDataSource})
      : _orderDataSource = orderDataSource;

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders(String userId) async {
    try {
      AppLogger.info('Repository: Getting orders for user: $userId');
      final orders = await _orderDataSource.getOrders(userId);
      return Right(orders.map((order) => order.toEntity()).toList());
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
  Future<Either<Failure, OrderEntity>> getOrderById(String orderId) async {
    try {
      AppLogger.info('Repository: Getting order by id: $orderId');
      final order = await _orderDataSource.getOrderById(orderId);
      return Right(order.toEntity());
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
  Future<Either<Failure, OrderEntity>> createOrder(OrderEntity order) async {
    try {
      AppLogger.info('Repository: Creating order for user: ${order.userId}');
      final orderModel = OrderModel.fromEntity(order);
      final createdOrder = await _orderDataSource.createOrder(orderModel);
      return Right(createdOrder.toEntity());
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
  Future<Either<Failure, OrderEntity>> updateOrderStatus(String orderId, String status) async {
    try {
      AppLogger.info('Repository: Updating order status: $orderId to $status');
      final updatedOrder = await _orderDataSource.updateOrderStatus(orderId, status);
      return Right(updatedOrder.toEntity());
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
  Future<Either<Failure, void>> cancelOrder(String orderId) async {
    try {
      AppLogger.info('Repository: Cancelling order: $orderId');
      await _orderDataSource.cancelOrder(orderId);
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
}
