import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    String? sortBy,
    bool? isFeatured,
    bool? isOnSale,
  });
  Future<Either<Failure, ProductEntity>> getProductById(String id);
  Future<Either<Failure, List<ProductEntity>>> getFeaturedProducts();
  Future<Either<Failure, List<ProductEntity>>> getNewProducts();
  Future<Either<Failure, List<ProductEntity>>> getOnSaleProducts();
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
}
