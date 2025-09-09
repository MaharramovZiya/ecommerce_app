import 'package:get_it/get_it.dart';
import '../../uikit/cubit/search_cubit.dart';
import '../../presentation/filter/cubit/filter_cubit.dart';
import '../../domain/usecases/product/search_products_usecase.dart';

final GetIt getIt = GetIt.instance;

void configureProviders() {
  // Search Cubit
  getIt.registerFactory(() => SearchCubit(
    searchProductsUseCase: getIt<SearchProductsUseCase>(),
  ));

  // Filter Cubit
  getIt.registerFactory(() => FilterCubit());
}
