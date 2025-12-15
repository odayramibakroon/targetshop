class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}

class CacheException implements Exception {
  final String? message;
  CacheException([this.message]);
}

class NetworkException implements Exception {
  final String? message;
  NetworkException([this.message]);
}

class UnknownException implements Exception {
  final String? message;
  UnknownException([this.message]);
}

class InvalidInputException implements Exception {
  final String? message;
  InvalidInputException([this.message]);
}

class AuthenticationException implements Exception {
  final String? message;
  AuthenticationException([this.message]);
}

class PermissionDeniedException implements Exception {
  final String? message;
  PermissionDeniedException([this.message]);
}

class NotFoundException implements Exception {
  final String? message;
  NotFoundException([this.message]);
}

class TimeoutException implements Exception {
  final String? message;
  TimeoutException([this.message]);
}

class AlreadyExistsException implements Exception {
  final String? message;
  AlreadyExistsException([this.message]);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class SignInException implements Exception {
  final String? message;
  SignInException([this.message]);
}