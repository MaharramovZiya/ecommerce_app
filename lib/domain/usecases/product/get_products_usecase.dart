import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

@injectable
class GetProductsUseCase implements UseCase<List<ProductEntity>, GetProductsParams> {
  final ProductRepository _productRepository;

  GetProductsUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetProductsParams params) async {
    return await _productRepository.getProducts(
      page: params.page,
      limit: params.limit,
      category: params.category,
      search: params.search,
      sortBy: params.sortBy,
      isFeatured: params.isFeatured,
      isOnSale: params.isOnSale,
    );
  }
}

class GetProductsParams {
  final int page;
  final int limit;
  final String? category;
  final String? search;
  final String? sortBy;
  final bool? isFeatured;
  final bool? isOnSale;

  GetProductsParams({
    this.page = 1,
    this.limit = 20,
    this.category,
    this.search,
    this.sortBy,
    this.isFeatured,
    this.isOnSale,
  });
}
