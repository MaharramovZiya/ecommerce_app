import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

@injectable
class GetFeaturedProductsUseCase implements UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository _productRepository;

  GetFeaturedProductsUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await _productRepository.getFeaturedProducts();
  }
}
