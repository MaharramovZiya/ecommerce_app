import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/cart_item_entity.dart';
import '../../repositories/cart_repository.dart';

@injectable
class GetCartItemsUseCase implements UseCase<List<CartItemEntity>, GetCartItemsParams> {
  final CartRepository _cartRepository;

  GetCartItemsUseCase({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, List<CartItemEntity>>> call(GetCartItemsParams params) async {
    return await _cartRepository.getCartItems(params.userId);
  }
}

class GetCartItemsParams {
  final String userId;

  GetCartItemsParams({required this.userId});
}
