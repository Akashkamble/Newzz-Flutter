class AppException implements Exception {
  final _message;

  AppException(this._message);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message]) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message);
}

class NetworkConnectionException extends AppException {
  NetworkConnectionException([String message]) : super(message);
}
