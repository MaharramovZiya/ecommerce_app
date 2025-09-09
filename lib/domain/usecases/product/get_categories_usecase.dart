import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/product_repository.dart';

@injectable
class GetCategoriesUseCase implements UseCase<List<String>, NoParams> {
  final ProductRepository _productRepository;

  GetCategoriesUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await _productRepository.getCategories();
  }
}
