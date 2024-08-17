class AppException implements Exception {
  AppException(this.message, this.prefix);
  final message;
  final prefix;
  @override
  String toString() {
    return "$prefix $message ";
  }
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, " Invalid Request");
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, " Error During Communication");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, " unauthorized request ");
}
