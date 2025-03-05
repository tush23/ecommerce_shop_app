abstract class Failure {
  final String message;

  Failure({this.message = 'An unexpected error occurred'});
}

class ServerFailure extends Failure {
  ServerFailure({String message = 'Server error occurred'}) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({String message = 'Cache error occurred'}) : super(message: message);
}
