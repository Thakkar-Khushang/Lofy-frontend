class AppException implements Exception {
  final message;
  AppException([this.message]);
  String toString() {
    return message;
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message);
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message);
}
