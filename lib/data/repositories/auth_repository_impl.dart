import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/utils/logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../models/user_model.dart';

@injectable
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AppLogger.info('Repository: Signing in user with email: $email');
      final userModel = await _authDataSource.signInWithEmailAndPassword(email, password);
      AppLogger.info('Repository: Sign in successful');
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      AppLogger.error('Repository: Auth exception during sign in: ${e.message}');
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception during sign in: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error during sign in: $e');
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      AppLogger.info('Repository: Signing up user with email: $email');
      final userModel = await _authDataSource.signUpWithEmailAndPassword(email, password, name);
      AppLogger.info('Repository: Sign up successful');
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      AppLogger.error('Repository: Auth exception during sign up: ${e.message}');
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception during sign up: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error during sign up: $e');
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      AppLogger.info('Repository: Signing out user');
      await _authDataSource.signOut();
      AppLogger.info('Repository: Sign out successful');
      return const Right(null);
    } on AuthException catch (e) {
      AppLogger.error('Repository: Auth exception during sign out: ${e.message}');
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception during sign out: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error during sign out: $e');
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      AppLogger.info('Repository: Getting current user');
      final userModel = await _authDataSource.getCurrentUser();
      AppLogger.info('Repository: Get current user successful');
      return Right(userModel?.toEntity());
    } on AuthException catch (e) {
      AppLogger.error('Repository: Auth exception during get current user: ${e.message}');
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception during get current user: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error during get current user: $e');
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      AppLogger.info('Repository: Resetting password for email: $email');
      await _authDataSource.resetPassword(email);
      AppLogger.info('Repository: Password reset successful');
      return const Right(null);
    } on AuthException catch (e) {
      AppLogger.error('Repository: Auth exception during password reset: ${e.message}');
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception during password reset: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error during password reset: $e');
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(UserEntity user) async {
    try {
      AppLogger.info('Repository: Updating profile for user: ${user.id}');
      final userModel = UserModel.fromEntity(user);
      final updatedUserModel = await _authDataSource.updateProfile(userModel);
      AppLogger.info('Repository: Profile update successful');
      return Right(updatedUserModel.toEntity());
    } on AuthException catch (e) {
      AppLogger.error('Repository: Auth exception during profile update: ${e.message}');
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      AppLogger.error('Repository: Server exception during profile update: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error during profile update: $e');
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
