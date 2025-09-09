class AppException implements Exception {
  final String message;
  final int? code;
  final dynamic originalException;

  const AppException({
    required this.message,
    this.code,
    this.originalException,
  });

  @override
  String toString() => 'AppException: $message';
}

// Network exceptions
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Network error occurred',
    super.code,
    super.originalException,
  });
}

class ServerException extends AppException {
  const ServerException({
    super.message = 'Server error occurred',
    super.code,
    super.originalException,
  });
}

class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timeout',
    super.code,
    super.originalException,
  });
}

// Authentication exceptions
class AuthException extends AppException {
  const AuthException({
    super.message = 'Authentication error',
    super.code,
    super.originalException,
  });
}

class InvalidCredentialsException extends AppException {
  const InvalidCredentialsException({
    super.message = 'Invalid credentials',
    super.code,
    super.originalException,
  });
}

class UserNotFoundException extends AppException {
  const UserNotFoundException({
    super.message = 'User not found',
    super.code,
    super.originalException,
  });
}

class EmailAlreadyExistsException extends AppException {
  const EmailAlreadyExistsException({
    super.message = 'Email already exists',
    super.code,
    super.originalException,
  });
}

// Data exceptions
class CacheException extends AppException {
  const CacheException({
    super.message = 'Cache error',
    super.code,
    super.originalException,
  });
}

class DataNotFoundException extends AppException {
  const DataNotFoundException({
    super.message = 'Data not found',
    super.code,
    super.originalException,
  });
}

class InvalidDataException extends AppException {
  const InvalidDataException({
    super.message = 'Invalid data',
    super.code,
    super.originalException,
  });
}

// Validation exceptions
class ValidationException extends AppException {
  const ValidationException({
    super.message = 'Validation error',
    super.code,
    super.originalException,
  });
}

// Permission exceptions
class PermissionException extends AppException {
  const PermissionException({
    super.message = 'Permission denied',
    super.code,
    super.originalException,
  });
}

// File exceptions
class FileException extends AppException {
  const FileException({
    super.message = 'File error',
    super.code,
    super.originalException,
  });
}

class FileNotFoundException extends AppException {
  const FileNotFoundException({
    super.message = 'File not found',
    super.code,
    super.originalException,
  });
}

class FileUploadException extends AppException {
  const FileUploadException({
    super.message = 'File upload failed',
    super.code,
    super.originalException,
  });
}

// Business logic exceptions
class BusinessLogicException extends AppException {
  const BusinessLogicException({
    super.message = 'Business logic error',
    super.code,
    super.originalException,
  });
}

class InsufficientStockException extends AppException {
  const InsufficientStockException({
    super.message = 'Insufficient stock',
    super.code,
    super.originalException,
  });
}

class PaymentException extends AppException {
  const PaymentException({
    super.message = 'Payment failed',
    super.code,
    super.originalException,
  });
}

// Generic exception
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'Unknown error occurred',
    super.code,
    super.originalException,
  });
}
