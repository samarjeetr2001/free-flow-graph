abstract class AppException {
  final String message;
  final StackTrace? stackTrace;

  AppException({required this.message, this.stackTrace});
}

class RestException extends AppException {
  final int? statusCode;
  final dynamic errorResponse;

  RestException({
    required this.statusCode,
    this.errorResponse,
    required super.message,
    super.stackTrace,
  });
}

class FatalException extends AppException {
  final Object exception;

  FatalException({
    required this.exception,
    required super.message,
    super.stackTrace,
  });
}
