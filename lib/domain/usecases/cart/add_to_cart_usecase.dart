import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/cart_item_entity.dart';
import '../../repositories/cart_repository.dart';

@injectable
class AddToCartUseCase implements UseCase<CartItemEntity, AddToCartParams> {
  final CartRepository _cartRepository;

  AddToCartUseCase({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartItemEntity>> call(AddToCartParams params) async {
    return await _cartRepository.addToCart(params.item);
  }
}

class AddToCartParams {
  final CartItemEntity item;

  AddToCartParams({required this.item});
}
