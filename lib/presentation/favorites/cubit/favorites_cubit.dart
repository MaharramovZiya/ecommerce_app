import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../core/utils/logger.dart';
import '../../../domain/entities/favorite_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/repositories/favorites_repository.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/usecases/product/get_product_by_id_usecase.dart';

part 'favorites_state.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _favoritesRepository;
  final ProductRepository _productRepository;
  
  FavoritesCubit({
    required FavoritesRepository favoritesRepository,
    required ProductRepository productRepository,
  }) : _favoritesRepository = favoritesRepository,
       _productRepository = productRepository,
       super(FavoritesInitial());

  final String _testUserId = '00000000-0000-0000-0000-000000000000';
  List<FavoriteEntity> _favorites = [];
  Set<String> _favoriteProductIds = {};

  List<FavoriteEntity> get favorites => _favorites;
  Set<String> get favoriteProductIds => _favoriteProductIds;

  bool isFavorite(String productId) {
    return _favoriteProductIds.contains(productId);
  }

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    
    final result = await _favoritesRepository.getFavorites(_testUserId);
    
    result.fold(
      (failure) => emit(FavoritesError(_mapFailureToMessage(failure))),
      (favorites) async {
        _favorites = favorites;
        _favoriteProductIds = favorites.map((f) => f.product.id).toSet();
        
        // Əgər məhsul məlumatları yoxdursa, onları ayrıca yüklə
        final List<FavoriteEntity> loadedFavorites = [];
        for (final favorite in favorites) {
          if (favorite.product.name == 'Loading...') {
            // Məhsul məlumatlarını yüklə
            final productResult = await _getProductById(favorite.product.id);
            if (productResult != null) {
              loadedFavorites.add(FavoriteEntity(
                id: favorite.id,
                userId: favorite.userId,
                product: productResult,
                createdAt: favorite.createdAt,
                updatedAt: favorite.updatedAt,
              ));
            }
          } else {
            loadedFavorites.add(favorite);
          }
        }
        
        _favorites = loadedFavorites;
        emit(FavoritesLoaded(loadedFavorites));
      },
    );
  }

  Future<ProductEntity?> _getProductById(String productId) async {
    try {
      final result = await _productRepository.getProductById(productId);
      return result.fold(
        (failure) => null,
        (product) => product,
      );
    } catch (e) {
      AppLogger.error('Failed to load product $productId: $e');
      return null;
    }
  }

  Future<void> toggleFavorite(String productId) async {
    if (_favoriteProductIds.contains(productId)) {
      await removeFromFavorites(productId);
    } else {
      await addToFavorites(productId);
    }
  }

  Future<void> addToFavorites(String productId) async {
    final result = await _favoritesRepository.addToFavorites(_testUserId, productId);
    
    result.fold(
      (failure) => emit(FavoritesError(_mapFailureToMessage(failure))),
      (favorite) {
        _favorites.add(favorite);
        _favoriteProductIds.add(productId);
        emit(FavoritesUpdated(_favorites));
      },
    );
  }

  Future<void> removeFromFavorites(String productId) async {
    final result = await _favoritesRepository.removeFromFavorites(_testUserId, productId);
    
    result.fold(
      (failure) => emit(FavoritesError(_mapFailureToMessage(failure))),
      (_) {
        _favorites.removeWhere((f) => f.product.id == productId);
        _favoriteProductIds.remove(productId);
        emit(FavoritesUpdated(_favorites));
      },
    );
  }

  Future<void> clearFavorites() async {
    for (final productId in _favoriteProductIds.toList()) {
      await removeFromFavorites(productId);
    }
    emit(FavoritesCleared());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error. Please try again later.';
      case NetworkFailure:
        return 'Network error. Please check your connection.';
      case DataNotFoundFailure:
        return 'Favorites not found.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
