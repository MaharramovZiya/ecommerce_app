part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileOrdersLoaded extends ProfileState {
  final List<OrderEntity> orders;

  const ProfileOrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
