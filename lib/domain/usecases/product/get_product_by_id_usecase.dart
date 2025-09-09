import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

@injectable
class GetProductByIdUseCase implements UseCase<ProductEntity, GetProductByIdParams> {
  final ProductRepository _productRepository;

  GetProductByIdUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<Either<Failure, ProductEntity>> call(GetProductByIdParams params) async {
    return await _productRepository.getProductById(params.id);
  }
}

class GetProductByIdParams {
  final String id;

  GetProductByIdParams({required this.id});
}
