import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth/sign_in_usecase.dart';
import '../../../domain/usecases/auth/sign_up_usecase.dart';
import '../../../domain/usecases/auth/sign_out_usecase.dart';
import '../../../domain/usecases/auth/get_current_user_usecase.dart';
import '../../../domain/usecases/auth/reset_password_usecase.dart';
import '../../../domain/usecases/auth/update_profile_usecase.dart';
import '../../../core/usecases/usecase.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  AuthCubit({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _signOutUseCase = signOutUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    
    final result = await _signInUseCase(SignInParams(email: email, password: password));
    
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());
    
    final result = await _signUpUseCase(SignUpParams(email: email, password: password, name: name));
    
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    
    final result = await _signOutUseCase(const NoParams());
    
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    
    final result = await _getCurrentUserUseCase(const NoParams());
    
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    
    final result = await _resetPasswordUseCase(ResetPasswordParams(email: email));
    
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (_) => emit(AuthPasswordResetSent()),
    );
  }

  Future<void> updateProfile(UserEntity user) async {
    emit(AuthLoading());
    
    final result = await _updateProfileUseCase(UpdateProfileParams(user: user));
    
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (updatedUser) => emit(AuthAuthenticated(updatedUser)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'Network error. Please check your connection.';
      case ServerFailure:
        return 'Server error. Please try again later.';
      case AuthFailure:
        return 'Authentication failed.';
      case InvalidCredentialsFailure:
        return 'Invalid email or password.';
      case EmailAlreadyExistsFailure:
        return 'Email already exists.';
      case WeakPasswordFailure:
        return 'Password is too weak.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
