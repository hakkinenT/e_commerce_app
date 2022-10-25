import 'package:e_commerce_app/core/error/exception.dart';

class StatusCodeMap {
  static dynamic mapStatusCode(
      {required dynamic Function() successFunction, required int code}) {
    switch (code) {
      case 200:
        return successFunction();
      case 201:
        return successFunction();
      case 400:
        throw BadRequestException();
      case 401:
        throw UnauthorizedException();
      case 403:
        throw ForbiddenException();
      case 404:
        throw NotFoundException();
      case 408:
        throw RequestTimeoutException();
      case 429:
        throw TooManyRequestsException();
      case 499:
        throw ClientClosedException();
      case 500:
        throw ServerException();
      default:
        throw Exception();
    }
  }
}
