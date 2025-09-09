import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_constants.dart';
import 'data/datasources/auth_datasource.dart';
import 'data/datasources/product_datasource.dart';
import 'data/datasources/cart_datasource.dart';
import 'data/datasources/order_datasource.dart';
import 'data/datasources/favorites_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'data/repositories/order_repository_impl.dart';
import 'data/repositories/favorites_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/repositories/favorites_repository.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Initialize Supabase
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  // Register SupabaseClient manually
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // Register abstract classes with their implementations
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(supabaseClient: getIt()));
  getIt.registerLazySingleton<ProductDataSource>(() => ProductDataSourceImpl(supabaseClient: getIt()));
  getIt.registerLazySingleton<CartDataSource>(() => CartDataSourceImpl(supabaseClient: getIt()));
  getIt.registerLazySingleton<OrderDataSource>(() => OrderDataSourceImpl(supabaseClient: getIt()));
  getIt.registerLazySingleton<FavoritesDataSource>(() => FavoritesDataSourceImpl(supabaseClient: getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authDataSource: getIt()));
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(productDataSource: getIt()));
  getIt.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(cartDataSource: getIt()));
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(orderDataSource: getIt()));
  getIt.registerLazySingleton<FavoritesRepository>(() => FavoritesRepositoryImpl(favoritesDataSource: getIt()));

  // Initialize GetIt with injectable
  getIt.init();
}
