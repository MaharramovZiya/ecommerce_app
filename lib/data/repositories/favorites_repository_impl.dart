import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/utils/logger.dart';
import '../../domain/entities/favorite_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_datasource.dart';

@injectable
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDataSource _favoritesDataSource;

  FavoritesRepositoryImpl({required FavoritesDataSource favoritesDataSource})
      : _favoritesDataSource = favoritesDataSource;

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites(String userId) async {
    try {
      AppLogger.info('Repository: Getting favorites for user: $userId');
      final favorites = await _favoritesDataSource.getFavorites(userId);
      return Right(favorites.map((favorite) => favorite.toEntity()).toList());
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, FavoriteEntity>> addToFavorites(String userId, String productId) async {
    try {
      AppLogger.info('Repository: Adding product $productId to favorites for user $userId');
      final favorite = await _favoritesDataSource.addToFavorites(userId, productId);
      return Right(favorite.toEntity());
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String userId, String productId) async {
    try {
      AppLogger.info('Repository: Removing product $productId from favorites for user $userId');
      await _favoritesDataSource.removeFromFavorites(userId, productId);
      return const Right(null);
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String userId, String productId) async {
    try {
      AppLogger.info('Repository: Checking if product $productId is favorite for user $userId');
      final isFavorite = await _favoritesDataSource.isFavorite(userId, productId);
      return Right(isFavorite);
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      AppLogger.error('Repository: Network exception: ${e.message}');
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unknown error: $e');
      return Left(UnknownFailure(message: 'An unknown error occurred: ${e.toString()}'));
    }
  }
}
