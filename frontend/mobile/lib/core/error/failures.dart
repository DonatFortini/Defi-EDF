abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => 'Failure: $message';
}

class ServerFailure extends Failure {
  ServerFailure([super.message = 'Server Failure']);
}

class NetworkFailure extends Failure {
  NetworkFailure([super.message = 'Network Failure']);
}
