import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:injectable/injectable.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/logger.dart';
import '../models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signUpWithEmailAndPassword(String email, String password, String name);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<void> resetPassword(String email);
  Future<UserModel> updateProfile(UserModel user);
}

@injectable
class AuthDataSourceImpl implements AuthDataSource {
  final supabase.SupabaseClient _supabaseClient;

  AuthDataSourceImpl({required supabase.SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      AppLogger.info('Attempting to sign in with email: $email');
      
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const AuthException(message: 'Sign in failed');
      }

      final userProfile = await _getUserProfile(response.user!.id);
      if (userProfile != null) {
        AppLogger.info('Sign in successful for user: ${userProfile.email}');
        return userProfile;
      }

      // Fallback to auth user data if profile doesn't exist
      final user = UserModel(
        id: response.user!.id,
        email: response.user!.email ?? email,
        name: response.user!.userMetadata?['name'] ?? email.split('@').first,
        createdAt: DateTime.tryParse(response.user!.createdAt ?? ''),
        updatedAt: DateTime.now(),
      );
      AppLogger.info('Sign in successful for user: ${user.email}');
      return user;
    } on AuthException {
      rethrow;
    } catch (e) {
      AppLogger.error('Sign in error: $e');
      if (e is AuthException) {
        rethrow;
      }
      throw AuthException(message: 'Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(String email, String password, String name) async {
    try {
      AppLogger.info('Attempting to sign up with email: $email');
      
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const AuthException(message: 'Sign up failed');
      }

      // Create user profile
      final userProfile = UserModel(
        id: response.user!.id,
        email: email,
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _createUserProfile(userProfile);
      AppLogger.info('Sign up successful for user: $email');
      
      return userProfile;
    } on AuthException {
      rethrow;
    } catch (e) {
      AppLogger.error('Sign up error: $e');
      if (e is AuthException) {
        rethrow;
      }
      throw AuthException(message: 'Sign up failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      AppLogger.info('Signing out user');
      await _supabaseClient.auth.signOut();
      AppLogger.info('Sign out successful');
    } catch (e) {
      AppLogger.error('Sign out error: $e');
      throw AuthException(message: 'Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        return null;
      }

      final userProfile = await _getUserProfile(user.id);
      if (userProfile != null) {
        return userProfile;
      }

      // Fallback to auth user data if profile doesn't exist
      return UserModel(
        id: user.id,
        email: user.email ?? '',
        name: user.userMetadata?['name'] ?? user.email?.split('@').first ?? 'User',
        createdAt: DateTime.tryParse(user.createdAt ?? ''),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      AppLogger.error('Get current user error: $e');
      throw AuthException(message: 'Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      AppLogger.info('Resetting password for email: $email');
      await _supabaseClient.auth.resetPasswordForEmail(email);
      AppLogger.info('Password reset email sent');
    } catch (e) {
      AppLogger.error('Reset password error: $e');
      throw AuthException(message: 'Password reset failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    try {
      AppLogger.info('Updating profile for user: ${user.id}');
      
      final response = await _supabaseClient
          .from('profiles')
          .update(user.toJson())
          .eq('id', user.id)
          .select()
          .single();

      final updatedUser = UserModel.fromJson(response);
      AppLogger.info('Profile updated successfully');
      
      return updatedUser;
    } catch (e) {
      AppLogger.error('Update profile error: $e');
      throw AuthException(message: 'Profile update failed: ${e.toString()}');
    }
  }

  Future<UserModel?> _getUserProfile(String userId) async {
    try {
      final response = await _supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) {
        return null;
      }

      return UserModel.fromJson(response);
    } catch (e) {
      AppLogger.error('Get user profile error: $e');
      throw AuthException(message: 'Failed to get user profile: ${e.toString()}');
    }
  }

  Future<void> _createUserProfile(UserModel user) async {
    try {
      await _supabaseClient
          .from('profiles')
          .insert(user.toJson());
    } catch (e) {
      AppLogger.error('Create user profile error: $e');
      throw AuthException(message: 'Failed to create user profile: ${e.toString()}');
    }
  }
}
