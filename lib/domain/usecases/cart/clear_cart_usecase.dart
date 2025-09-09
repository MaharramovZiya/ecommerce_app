import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/cart_repository.dart';

@injectable
class ClearCartUseCase implements UseCase<void, ClearCartParams> {
  final CartRepository _cartRepository;

  ClearCartUseCase({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, void>> call(ClearCartParams params) async {
    return await _cartRepository.clearCart(params.userId);
  }
}

class ClearCartParams {
  final String userId;

  ClearCartParams({required this.userId});
}
