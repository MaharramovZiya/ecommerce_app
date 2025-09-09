import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/logger.dart';
import '../models/favorite_model.dart';

abstract class FavoritesDataSource {
  Future<List<FavoriteModel>> getFavorites(String userId);
  Future<FavoriteModel> addToFavorites(String userId, String productId);
  Future<void> removeFromFavorites(String userId, String productId);
  Future<bool> isFavorite(String userId, String productId);
}

@injectable
class FavoritesDataSourceImpl implements FavoritesDataSource {
  final SupabaseClient _supabaseClient;

  FavoritesDataSourceImpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<List<FavoriteModel>> getFavorites(String userId) async {
    try {
      AppLogger.info('Fetching favorites for user: $userId');
      
      final response = await _supabaseClient
          .from('favorites')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final favorites = (response as List)
          .map((json) => FavoriteModel.fromJson(json))
          .toList();

      AppLogger.info('Fetched ${favorites.length} favorites');
      return favorites;
    } catch (e) {
      AppLogger.error('Get favorites error: $e');
      throw ServerException(message: 'Failed to fetch favorites: ${e.toString()}');
    }
  }

  @override
  Future<FavoriteModel> addToFavorites(String userId, String productId) async {
    try {
      AppLogger.info('Adding product $productId to favorites for user $userId');
      
      // Əvvəlcə yoxla ki, bu məhsul artıq favorites-də varmı
      final existing = await isFavorite(userId, productId);
      if (existing) {
        AppLogger.info('Product already in favorites');
        // Artıq varsa, mövcud olanı qaytar
        final response = await _supabaseClient
            .from('favorites')
            .select('*')
            .eq('user_id', userId)
            .eq('product_id', productId)
            .single();
        return FavoriteModel.fromJson(response);
      }
      
      final response = await _supabaseClient
          .from('favorites')
          .insert({
            'user_id': userId,
            'product_id': productId,
          })
          .select('*')
          .single();

      final favorite = FavoriteModel.fromJson(response);
      AppLogger.info('Product added to favorites successfully');
      
      return favorite;
    } catch (e) {
      AppLogger.error('Add to favorites error: $e');
      throw ServerException(message: 'Failed to add to favorites: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFromFavorites(String userId, String productId) async {
    try {
      AppLogger.info('Removing product $productId from favorites for user $userId');
      
      await _supabaseClient
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);

      AppLogger.info('Product removed from favorites successfully');
    } catch (e) {
      AppLogger.error('Remove from favorites error: $e');
      throw ServerException(message: 'Failed to remove from favorites: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFavorite(String userId, String productId) async {
    try {
      AppLogger.info('Checking if product $productId is favorite for user $userId');
      
      final response = await _supabaseClient
          .from('favorites')
          .select('id')
          .eq('user_id', userId)
          .eq('product_id', productId)
          .maybeSingle();

      final isFavorite = response != null;
      AppLogger.info('Product is favorite: $isFavorite');
      
      return isFavorite;
    } catch (e) {
      AppLogger.error('Check favorite error: $e');
      throw ServerException(message: 'Failed to check favorite status: ${e.toString()}');
    }
  }
}
