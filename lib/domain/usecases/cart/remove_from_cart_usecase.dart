import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/cart_repository.dart';

@injectable
class RemoveFromCartUseCase implements UseCase<void, RemoveFromCartParams> {
  final CartRepository _cartRepository;

  RemoveFromCartUseCase({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, void>> call(RemoveFromCartParams params) async {
    return await _cartRepository.removeFromCart(params.itemId);
  }
}

class RemoveFromCartParams {
  final String itemId;

  RemoveFromCartParams({required this.itemId});
}
