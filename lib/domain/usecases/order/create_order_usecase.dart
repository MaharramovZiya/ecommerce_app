import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/order_entity.dart';
import '../../repositories/order_repository.dart';

@injectable
class CreateOrderUseCase implements UseCase<OrderEntity, CreateOrderParams> {
  final OrderRepository _orderRepository;

  CreateOrderUseCase({required OrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, OrderEntity>> call(CreateOrderParams params) async {
    return await _orderRepository.createOrder(params.order);
  }
}

class CreateOrderParams {
  final OrderEntity order;

  CreateOrderParams({required this.order});
}
