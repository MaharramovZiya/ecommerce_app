import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/logger.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_datasource.dart';
import '../models/product_model.dart';

@injectable
class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _productDataSource;

  ProductRepositoryImpl({required ProductDataSource productDataSource})
      : _productDataSource = productDataSource;

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    String? sortBy,
    bool? isFeatured,
    bool? isOnSale,
  }) async {
    try {
      AppLogger.info('Repository: Getting products - page: $page, category: $category');
      final products = await _productDataSource.getProducts(
        page: page,
        limit: limit,
        category: category,
        search: search,
        sortBy: sortBy,
        isFeatured: isFeatured,
        isOnSale: isOnSale,
      );
      return Right(products.map((product) => product.toEntity()).toList());
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    try {
      AppLogger.info('Repository: Getting product by id: $id');
      final product = await _productDataSource.getProductById(id);
      return Right(product.toEntity());
    } on DataNotFoundException catch (e) {
      AppLogger.error('Repository: Data not found: ${e.message}');
      return Left(DataNotFoundFailure(message: e.message));
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getFeaturedProducts() async {
    try {
      AppLogger.info('Repository: Getting featured products');
      final products = await _productDataSource.getFeaturedProducts();
      return Right(products.map((product) => product.toEntity()).toList());
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getNewProducts() async {
    try {
      AppLogger.info('Repository: Getting new products');
      final products = await _productDataSource.getNewProducts();
      return Right(products.map((product) => product.toEntity()).toList());
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getOnSaleProducts() async {
    try {
      AppLogger.info('Repository: Getting on sale products');
      final products = await _productDataSource.getOnSaleProducts();
      return Right(products.map((product) => product.toEntity()).toList());
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      AppLogger.info('Repository: Getting categories');
      final categories = await _productDataSource.getCategories();
      return Right(categories);
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query) async {
    try {
      AppLogger.info('Repository: Searching products with query: $query');
      final products = await _productDataSource.searchProducts(query);
      return Right(products.map((product) => product.toEntity()).toList());
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }
}
