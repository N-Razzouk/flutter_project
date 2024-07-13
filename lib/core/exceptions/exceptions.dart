abstract class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => 'AppException: $message';
}

class InsufficientBalanceException extends AppException {
  InsufficientBalanceException() : super('Insufficient balance');
}
