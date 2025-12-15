abstract class Failure {
  final String? message;
  Failure([this.message]);
}

class ServerFailure extends Failure {
  ServerFailure([super.message]);
}

class CacheFailure extends Failure {
  CacheFailure([super.message]);
}

class NetworkFailure extends Failure {
  NetworkFailure([super.message]);
}

class UnknownFailure extends Failure {
  UnknownFailure([super.message]);
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure([super.message]);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure([super.message]);
}

class PermissionDeniedFailure extends Failure {
  PermissionDeniedFailure([super.message]);
}

class NotFoundFailure extends Failure {
  NotFoundFailure([super.message]);
}

class TimeoutFailure extends Failure {
  TimeoutFailure([super.message]);
}

class AlreadyExistsFailure extends Failure {
  AlreadyExistsFailure([super.message]);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

class RouteFailure extends Failure {
  RouteFailure(super.message);
}

class VerificationFailure extends Failure {
  VerificationFailure([super.message]);
}