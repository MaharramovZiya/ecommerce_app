// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ecommerce_apps/data/datasources/auth_datasource.dart' as _i552;
import 'package:ecommerce_apps/data/datasources/cart_datasource.dart' as _i561;
import 'package:ecommerce_apps/data/datasources/favorites_datasource.dart'
    as _i984;
import 'package:ecommerce_apps/data/datasources/order_datasource.dart' as _i202;
import 'package:ecommerce_apps/data/datasources/product_datasource.dart'
    as _i490;
import 'package:ecommerce_apps/data/repositories/auth_repository_impl.dart'
    as _i993;
import 'package:ecommerce_apps/data/repositories/cart_repository_impl.dart'
    as _i666;
import 'package:ecommerce_apps/data/repositories/favorites_repository_impl.dart'
    as _i594;
import 'package:ecommerce_apps/data/repositories/order_repository_impl.dart'
    as _i473;
import 'package:ecommerce_apps/data/repositories/product_repository_impl.dart'
    as _i131;
import 'package:ecommerce_apps/domain/repositories/auth_repository.dart'
    as _i496;
import 'package:ecommerce_apps/domain/repositories/cart_repository.dart'
    as _i1013;
import 'package:ecommerce_apps/domain/repositories/favorites_repository.dart'
    as _i626;
import 'package:ecommerce_apps/domain/repositories/order_repository.dart'
    as _i1020;
import 'package:ecommerce_apps/domain/repositories/product_repository.dart'
    as _i15;
import 'package:ecommerce_apps/domain/usecases/auth/get_current_user_usecase.dart'
    as _i497;
import 'package:ecommerce_apps/domain/usecases/auth/reset_password_usecase.dart'
    as _i195;
import 'package:ecommerce_apps/domain/usecases/auth/sign_in_usecase.dart'
    as _i176;
import 'package:ecommerce_apps/domain/usecases/auth/sign_out_usecase.dart'
    as _i807;
import 'package:ecommerce_apps/domain/usecases/auth/sign_up_usecase.dart'
    as _i578;
import 'package:ecommerce_apps/domain/usecases/auth/update_profile_usecase.dart'
    as _i518;
import 'package:ecommerce_apps/domain/usecases/cart/add_to_cart_usecase.dart'
    as _i795;
import 'package:ecommerce_apps/domain/usecases/cart/clear_cart_usecase.dart'
    as _i469;
import 'package:ecommerce_apps/domain/usecases/cart/get_cart_items_usecase.dart'
    as _i773;
import 'package:ecommerce_apps/domain/usecases/cart/remove_from_cart_usecase.dart'
    as _i594;
import 'package:ecommerce_apps/domain/usecases/cart/update_cart_item_usecase.dart'
    as _i789;
import 'package:ecommerce_apps/domain/usecases/order/create_order_usecase.dart'
    as _i128;
import 'package:ecommerce_apps/domain/usecases/order/get_orders_usecase.dart'
    as _i128;
import 'package:ecommerce_apps/domain/usecases/product/get_categories_usecase.dart'
    as _i183;
import 'package:ecommerce_apps/domain/usecases/product/get_featured_products_usecase.dart'
    as _i926;
import 'package:ecommerce_apps/domain/usecases/product/get_product_by_id_usecase.dart'
    as _i553;
import 'package:ecommerce_apps/domain/usecases/product/get_products_usecase.dart'
    as _i873;
import 'package:ecommerce_apps/domain/usecases/product/search_products_usecase.dart'
    as _i306;
import 'package:ecommerce_apps/presentation/auth/cubit/auth_cubit.dart'
    as _i966;
import 'package:ecommerce_apps/presentation/cart/cubit/cart_cubit.dart'
    as _i531;
import 'package:ecommerce_apps/presentation/favorites/cubit/favorites_cubit.dart'
    as _i651;
import 'package:ecommerce_apps/presentation/filter/cubit/filter_cubit.dart'
    as _i359;
import 'package:ecommerce_apps/presentation/home/cubit/home_cubit.dart'
    as _i470;
import 'package:ecommerce_apps/presentation/product_detail/cubit/product_detail_cubit.dart'
    as _i913;
import 'package:ecommerce_apps/presentation/profile/cubit/profile_cubit.dart'
    as _i313;
import 'package:ecommerce_apps/uikit/cubit/search_cubit.dart' as _i161;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i359.FilterCubit>(() => _i359.FilterCubit());
    gh.factory<_i128.CreateOrderUseCase>(
      () => _i128.CreateOrderUseCase(
        orderRepository: gh<_i1020.OrderRepository>(),
      ),
    );
    gh.factory<_i128.GetOrdersUseCase>(
      () =>
          _i128.GetOrdersUseCase(orderRepository: gh<_i1020.OrderRepository>()),
    );
    gh.factory<_i795.AddToCartUseCase>(
      () => _i795.AddToCartUseCase(cartRepository: gh<_i1013.CartRepository>()),
    );
    gh.factory<_i469.ClearCartUseCase>(
      () => _i469.ClearCartUseCase(cartRepository: gh<_i1013.CartRepository>()),
    );
    gh.factory<_i773.GetCartItemsUseCase>(
      () => _i773.GetCartItemsUseCase(
        cartRepository: gh<_i1013.CartRepository>(),
      ),
    );
    gh.factory<_i594.RemoveFromCartUseCase>(
      () => _i594.RemoveFromCartUseCase(
        cartRepository: gh<_i1013.CartRepository>(),
      ),
    );
    gh.factory<_i789.UpdateCartItemUseCase>(
      () => _i789.UpdateCartItemUseCase(
        cartRepository: gh<_i1013.CartRepository>(),
      ),
    );
    gh.factory<_i497.GetCurrentUserUseCase>(
      () => _i497.GetCurrentUserUseCase(
        authRepository: gh<_i496.AuthRepository>(),
      ),
    );
    gh.factory<_i195.ResetPasswordUseCase>(
      () => _i195.ResetPasswordUseCase(
        authRepository: gh<_i496.AuthRepository>(),
      ),
    );
    gh.factory<_i176.SignInUseCase>(
      () => _i176.SignInUseCase(authRepository: gh<_i496.AuthRepository>()),
    );
    gh.factory<_i807.SignOutUseCase>(
      () => _i807.SignOutUseCase(authRepository: gh<_i496.AuthRepository>()),
    );
    gh.factory<_i578.SignUpUseCase>(
      () => _i578.SignUpUseCase(authRepository: gh<_i496.AuthRepository>()),
    );
    gh.factory<_i518.UpdateProfileUseCase>(
      () => _i518.UpdateProfileUseCase(
        authRepository: gh<_i496.AuthRepository>(),
      ),
    );
    gh.factory<_i594.FavoritesRepositoryImpl>(
      () => _i594.FavoritesRepositoryImpl(
        favoritesDataSource: gh<_i984.FavoritesDataSource>(),
      ),
    );
    gh.factory<_i313.ProfileCubit>(
      () => _i313.ProfileCubit(
        getCurrentUserUseCase: gh<_i497.GetCurrentUserUseCase>(),
        updateProfileUseCase: gh<_i518.UpdateProfileUseCase>(),
        getOrdersUseCase: gh<_i128.GetOrdersUseCase>(),
      ),
    );
    gh.factory<_i473.OrderRepositoryImpl>(
      () => _i473.OrderRepositoryImpl(
        orderDataSource: gh<_i202.OrderDataSource>(),
      ),
    );
    gh.factory<_i131.ProductRepositoryImpl>(
      () => _i131.ProductRepositoryImpl(
        productDataSource: gh<_i490.ProductDataSource>(),
      ),
    );
    gh.factory<_i666.CartRepositoryImpl>(
      () =>
          _i666.CartRepositoryImpl(cartDataSource: gh<_i561.CartDataSource>()),
    );
    gh.factory<_i183.GetCategoriesUseCase>(
      () => _i183.GetCategoriesUseCase(
        productRepository: gh<_i15.ProductRepository>(),
      ),
    );
    gh.factory<_i926.GetFeaturedProductsUseCase>(
      () => _i926.GetFeaturedProductsUseCase(
        productRepository: gh<_i15.ProductRepository>(),
      ),
    );
    gh.factory<_i873.GetProductsUseCase>(
      () => _i873.GetProductsUseCase(
        productRepository: gh<_i15.ProductRepository>(),
      ),
    );
    gh.factory<_i553.GetProductByIdUseCase>(
      () => _i553.GetProductByIdUseCase(
        productRepository: gh<_i15.ProductRepository>(),
      ),
    );
    gh.factory<_i306.SearchProductsUseCase>(
      () => _i306.SearchProductsUseCase(
        productRepository: gh<_i15.ProductRepository>(),
      ),
    );
    gh.factory<_i993.AuthRepositoryImpl>(
      () =>
          _i993.AuthRepositoryImpl(authDataSource: gh<_i552.AuthDataSource>()),
    );
    gh.factory<_i531.CartCubit>(
      () => _i531.CartCubit(
        getCartItemsUseCase: gh<_i773.GetCartItemsUseCase>(),
        addToCartUseCase: gh<_i795.AddToCartUseCase>(),
        updateCartItemUseCase: gh<_i789.UpdateCartItemUseCase>(),
        removeFromCartUseCase: gh<_i594.RemoveFromCartUseCase>(),
        clearCartUseCase: gh<_i469.ClearCartUseCase>(),
      ),
    );
    gh.factory<_i552.AuthDataSourceImpl>(
      () =>
          _i552.AuthDataSourceImpl(supabaseClient: gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i561.CartDataSourceImpl>(
      () =>
          _i561.CartDataSourceImpl(supabaseClient: gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i984.FavoritesDataSourceImpl>(
      () => _i984.FavoritesDataSourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i202.OrderDataSourceImpl>(
      () =>
          _i202.OrderDataSourceImpl(supabaseClient: gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i490.ProductDataSourceImpl>(
      () => _i490.ProductDataSourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i651.FavoritesCubit>(
      () => _i651.FavoritesCubit(
        favoritesRepository: gh<_i626.FavoritesRepository>(),
        productRepository: gh<_i15.ProductRepository>(),
      ),
    );
    gh.factory<_i913.ProductDetailCubit>(
      () => _i913.ProductDetailCubit(
        getProductByIdUseCase: gh<_i553.GetProductByIdUseCase>(),
      ),
    );
    gh.factory<_i966.AuthCubit>(
      () => _i966.AuthCubit(
        signInUseCase: gh<_i176.SignInUseCase>(),
        signUpUseCase: gh<_i578.SignUpUseCase>(),
        signOutUseCase: gh<_i807.SignOutUseCase>(),
        getCurrentUserUseCase: gh<_i497.GetCurrentUserUseCase>(),
        resetPasswordUseCase: gh<_i195.ResetPasswordUseCase>(),
        updateProfileUseCase: gh<_i518.UpdateProfileUseCase>(),
      ),
    );
    gh.factory<_i470.HomeCubit>(
      () => _i470.HomeCubit(
        getProductsUseCase: gh<_i873.GetProductsUseCase>(),
        getFeaturedProductsUseCase: gh<_i926.GetFeaturedProductsUseCase>(),
        getCategoriesUseCase: gh<_i183.GetCategoriesUseCase>(),
        searchProductsUseCase: gh<_i306.SearchProductsUseCase>(),
      ),
    );
    gh.factory<_i161.SearchCubit>(
      () => _i161.SearchCubit(
        searchProductsUseCase: gh<_i306.SearchProductsUseCase>(),
      ),
    );
    return this;
  }
}
