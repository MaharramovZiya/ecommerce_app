import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/cart_item_entity.dart';
import '../../repositories/cart_repository.dart';

@injectable
class UpdateCartItemUseCase implements UseCase<CartItemEntity, UpdateCartItemParams> {
  final CartRepository _cartRepository;

  UpdateCartItemUseCase({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartItemEntity>> call(UpdateCartItemParams params) async {
    return await _cartRepository.updateCartItem(params.itemId, params.quantity);
  }
}

class UpdateCartItemParams {
  final String itemId;
  final int quantity;

  UpdateCartItemParams({
    required this.itemId,
    required this.quantity,
  });
}
