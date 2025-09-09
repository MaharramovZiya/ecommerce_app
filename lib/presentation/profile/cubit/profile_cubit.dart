import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/auth/get_current_user_usecase.dart';
import '../../../domain/usecases/auth/update_profile_usecase.dart';
import '../../../domain/usecases/order/get_orders_usecase.dart';
import '../../../core/usecases/usecase.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final GetOrdersUseCase _getOrdersUseCase;

  ProfileCubit({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required GetOrdersUseCase getOrdersUseCase,
  })  : _getCurrentUserUseCase = getCurrentUserUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        _getOrdersUseCase = getOrdersUseCase,
        super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    
    final result = await _getCurrentUserUseCase(const NoParams());
    
    result.fold(
      (failure) => emit(ProfileError(_mapFailureToMessage(failure))),
      (user) {
        if (user != null) {
          emit(ProfileLoaded(user));
        } else {
          emit(ProfileError('User not found'));
        }
      },
    );
  }

  Future<void> updateProfile(UserEntity user) async {
    emit(ProfileLoading());
    
    final result = await _updateProfileUseCase(UpdateProfileParams(user: user));
    
    result.fold(
      (failure) => emit(ProfileError(_mapFailureToMessage(failure))),
      (updatedUser) => emit(ProfileLoaded(updatedUser)),
    );
  }

  Future<void> loadOrders(String userId) async {
    emit(ProfileLoading());
    
    final result = await _getOrdersUseCase(GetOrdersParams(userId: userId));
    
    result.fold(
      (failure) => emit(ProfileError(_mapFailureToMessage(failure))),
      (orders) => emit(ProfileOrdersLoaded(orders)),
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
      default:
        return 'An unexpected error occurred.';
    }
  }
}
