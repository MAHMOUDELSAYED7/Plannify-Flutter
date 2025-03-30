abstract class Failure {
  final String message;
  final int? code;

  Failure(this.message, [this.code]);
}

class ServerFailure extends Failure {
  ServerFailure(super.message, [super.code]);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message, [super.code]);
}
