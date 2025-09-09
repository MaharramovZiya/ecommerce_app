import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';
import 'injection.dart';
import 'presentation/auth/cubit/auth_cubit.dart';
import 'presentation/home/cubit/home_cubit.dart';
import 'presentation/product_detail/cubit/product_detail_cubit.dart';
import 'presentation/cart/cubit/cart_cubit.dart';
import 'presentation/profile/cubit/profile_cubit.dart';
import 'uikit/cubit/search_cubit.dart';
import 'presentation/filter/cubit/filter_cubit.dart';
import 'presentation/favorites/cubit/favorites_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await configureDependencies();
  
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const EcommerceApp(),
    ),
  );
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<HomeCubit>()),
        BlocProvider(create: (_) => getIt<ProductDetailCubit>()),
        BlocProvider(create: (_) => getIt<CartCubit>()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider(create: (_) => getIt<FilterCubit>()),
        BlocProvider(create: (_) => getIt<FavoritesCubit>()),
      ],
      child: DevicePreview.appBuilder(
        context,
        MaterialApp.router(
          title: 'Ecommerce App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: AppRouter.router,
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
        ),
      ),
    );
  }
}
