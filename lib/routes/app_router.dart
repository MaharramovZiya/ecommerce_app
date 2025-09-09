import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/auth/views/login_view.dart';
import '../presentation/auth/views/register_view.dart';
import '../presentation/auth/views/forgot_password_view.dart';
import '../presentation/home/views/home_view.dart';
import '../presentation/search/views/search_view.dart';
import '../presentation/favorites/views/favorites_view.dart';
import '../presentation/product_detail/views/product_detail_view.dart';
import '../presentation/cart/views/cart_view.dart';
import '../presentation/cart/views/checkout_view.dart';
import '../presentation/profile/views/profile_view.dart';
import '../presentation/profile/views/orders_view.dart';
import '../presentation/splash/views/splash_view.dart';
import '../presentation/main/views/main_layout.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String profile = '/profile';
  static const String orders = '/orders';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => MainLayout(
          currentRoute: home,
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: search,
        name: 'search',
        builder: (context, state) => MainLayout(
          currentRoute: search,
          child: const SearchView(),
        ),
      ),
      GoRoute(
        path: favorites,
        name: 'favorites',
        builder: (context, state) => MainLayout(
          currentRoute: favorites,
          child: const FavoritesView(),
        ),
      ),
      GoRoute(
        path: productDetail,
        name: 'product-detail',
        builder: (context, state) {
          final productId = state.extra as String?;
          if (productId == null) {
            return const Scaffold(
              body: Center(
                child: Text('Product ID is required'),
              ),
            );
          }
          return ProductDetailView(productId: productId);
        },
      ),
      GoRoute(
        path: cart,
        name: 'cart',
        builder: (context, state) => MainLayout(
          currentRoute: cart,
          child: const CartView(),
        ),
      ),
      GoRoute(
        path: checkout,
        name: 'checkout',
        builder: (context, state) => const CheckoutView(),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => MainLayout(
          currentRoute: profile,
          child: const ProfileView(),
        ),
      ),
      GoRoute(
        path: orders,
        name: 'orders',
        builder: (context, state) => const OrdersView(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
