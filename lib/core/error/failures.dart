import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

// Network related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Network error. Please check your connection.',
    super.code,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Server error. Please try again later.',
    super.code,
  });
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Request timeout. Please try again.',
    super.code,
  });
}

// Authentication related failures
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Authentication failed.',
    super.code,
  });
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({
    super.message = 'Invalid email or password.',
    super.code,
  });
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure({
    super.message = 'User not found.',
    super.code,
  });
}

class EmailAlreadyExistsFailure extends Failure {
  const EmailAlreadyExistsFailure({
    super.message = 'Email already exists.',
    super.code,
  });
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure({
    super.message = 'Password is too weak.',
    super.code,
  });
}

// Data related failures
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Cache error occurred.',
    super.code,
  });
}

class DataNotFoundFailure extends Failure {
  const DataNotFoundFailure({
    super.message = 'Data not found.',
    super.code,
  });
}

class InvalidDataFailure extends Failure {
  const InvalidDataFailure({
    super.message = 'Invalid data format.',
    super.code,
  });
}

// Permission related failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    super.message = 'Permission denied.',
    super.code,
  });
}

class LocationPermissionFailure extends Failure {
  const LocationPermissionFailure({
    super.message = 'Location permission denied.',
    super.code,
  });
}

class CameraPermissionFailure extends Failure {
  const CameraPermissionFailure({
    super.message = 'Camera permission denied.',
    super.code,
  });
}

// File related failures
class FileNotFoundFailure extends Failure {
  const FileNotFoundFailure({
    super.message = 'File not found.',
    super.code,
  });
}

class FileUploadFailure extends Failure {
  const FileUploadFailure({
    super.message = 'File upload failed.',
    super.code,
  });
}

class FileSizeExceededFailure extends Failure {
  const FileSizeExceededFailure({
    super.message = 'File size exceeded.',
    super.code,
  });
}

// Validation related failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Validation failed.',
    super.code,
  });
}

class RequiredFieldFailure extends Failure {
  const RequiredFieldFailure({
    super.message = 'Required field is missing.',
    super.code,
  });
}

// Business logic failures
class InsufficientStockFailure extends Failure {
  const InsufficientStockFailure({
    super.message = 'Insufficient stock.',
    super.code,
  });
}

class PaymentFailure extends Failure {
  const PaymentFailure({
    super.message = 'Payment failed.',
    super.code,
  });
}

class OrderNotFoundFailure extends Failure {
  const OrderNotFoundFailure({
    super.message = 'Order not found.',
    super.code,
  });
}

// Generic failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unknown error occurred.',
    super.code,
  });
}
