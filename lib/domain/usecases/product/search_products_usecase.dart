import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

@injectable
class SearchProductsUseCase implements UseCase<List<ProductEntity>, SearchProductsParams> {
  final ProductRepository _productRepository;

  SearchProductsUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(SearchProductsParams params) async {
    return await _productRepository.searchProducts(params.query);
  }
}

class SearchProductsParams {
  final String query;

  SearchProductsParams({required this.query});
}
