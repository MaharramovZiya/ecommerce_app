import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/order_entity.dart';
import '../../repositories/order_repository.dart';

@injectable
class GetOrdersUseCase implements UseCase<List<OrderEntity>, GetOrdersParams> {
  final OrderRepository _orderRepository;

  GetOrdersUseCase({required OrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, List<OrderEntity>>> call(GetOrdersParams params) async {
    return await _orderRepository.getOrders(params.userId);
  }
}

class GetOrdersParams {
  final String userId;

  GetOrdersParams({required this.userId});
}
